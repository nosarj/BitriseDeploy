//
//  BuildServices.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

enum BuildServiceError: Error {
    case RawResponseFail
    case noIPAFiles
    case noPublicDownloadLink
}

struct BuildService {

    let downloadGroup = DispatchGroup()

    func downloadBuilds(appSlug: String, completion: @escaping (Result<[Build], Error>) -> Void) {
        var builds: [Build] = []
        downloadGroup.enter()
        NetworkService.downloadBuilds(appSlug: appSlug) { (result) in
            switch result {
            case .failure(let error):
                self.downloadGroup.leave()
                completion(.failure(error))
            case .success(let data):
                guard let rawResponse = BuildRawServerResponse.decode(data: data) else {
                    self.downloadGroup.leave()
                    completion(.failure(BuildServiceError.RawResponseFail))
                    return
                }
                builds = rawResponse.data
                for build in rawResponse.data {
                    self.downlaodBuildArtifact(appSlug: appSlug, build: build) { error in
                        if let error = error {
                            switch error {
                            case BuildServiceError.noPublicDownloadLink, BuildServiceError.noIPAFiles:
                                builds.removeAll { $0 == build }
                            default:
                                completion(.failure(error))
                            }
                        }
                    }
                }
                self.downloadGroup.leave()
            }
        }
        downloadGroup.notify(queue: .main) {
            completion(.success(builds))
        }
    }

    private func downlaodBuildArtifact(appSlug: String, build: Build, completion: @escaping (Error?) -> Void) {
        downloadGroup.enter()
        NetworkService.downloadArtifactList(appSlug: appSlug, buildSlug: build.slug ?? "") { (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let data):
                guard let rawResponse = ArtifactRawServerResponse.decode(data: data) else {
                    self.downloadGroup.leave()
                    completion(BuildServiceError.RawResponseFail)
                    return
                }
                self.downloadAppArtifact(appSlug: appSlug, artifacts: rawResponse.data, build: build) { (error) in
                    if let error = error {
                        completion(error)
                    }
                }
            }
            self.downloadGroup.leave()
        }
    }

    private func downloadAppArtifact(appSlug: String, artifacts: [Artifact], build: Build, completion: @escaping (Error?) -> Void) {
        if !artifacts.contains(where: { $0.artifactType == "ios-ipa" }) {
            completion(BuildServiceError.noIPAFiles)
            return
        }
        
        for artifact in artifacts {
            if artifact.artifactType == "ios-ipa" {
                guard artifact.isPublicPageEnabled else {
                    completion(BuildServiceError.noPublicDownloadLink)
                    continue
                }
                downloadGroup.enter()
                build.version = artifact.artifactMeta?.appInfo.version
                NetworkService.downloadArtifact(appSlug: appSlug, buildSlug: build.slug ?? "", artifactSlug: artifact.slug) { (result) in
                    switch result {
                    case .failure(let error):
                        self.downloadGroup.leave()
                        completion(error)
                    case .success(let data):
                        guard let rawResponse = AppArtifactRawResponse.decode(data: data) else {
                            self.downloadGroup.leave()
                            completion(BuildServiceError.RawResponseFail)
                            return
                        }
                        build.app = rawResponse.data
                        self.downloadGroup.leave()
                    }
                }
            }
        }
    }
}
