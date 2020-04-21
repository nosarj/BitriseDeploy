//
//  BuildServices.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

enum DecodeError: Error {
    case RawResponseFail
}

struct BuildService {

    let downloadGroup = DispatchGroup()

    func downloadBuilds(completion: @escaping (Result<[Build], Error>) -> Void) {
        var builds: [Build] = []
        downloadGroup.enter()
        NetworkService.downloadBuilds { (result) in
            switch result {
            case .failure(let error):
                self.downloadGroup.leave()
                completion(.failure(error))
            case .success(let data):
                guard let rawResponse = BuildRawServerResponse.decode(data: data) else {
                    self.downloadGroup.leave()
                    completion(.failure(DecodeError.RawResponseFail))
                    return
                }
                for build in rawResponse.data {
                    self.downlaodBuildArtifact(build: build) { error in
                        if let error = error {
                            self.downloadGroup.leave()
                            completion(.failure(error))
                        }
                    }
                }
                self.downloadGroup.leave()
                builds = rawResponse.data
            }
        }
        downloadGroup.notify(queue: .main) {
            completion(.success(builds))
        }
    }

    private func downlaodBuildArtifact(build: Build, completion: @escaping (Error?) -> Void) {
        downloadGroup.enter()
        NetworkService.downloadArtifactList(buildSlug: build.slug) { (result) in
            switch result {
            case .failure(let error):
                self.downloadGroup.leave()
                completion(error)
            case .success(let data):
                guard let rawResponse = ArtifactRawServerResponse.decode(data: data) else {
                    self.downloadGroup.leave()
                    completion(DecodeError.RawResponseFail)
                    return
                }
                self.downloadAppArtifact(artifacts: rawResponse.data, build: build) { (error) in
                    if let error = error {
                         self.downloadGroup.leave()
                        completion(error)
                    }
                }
            }
            self.downloadGroup.leave()
        }
    }

    private func downloadAppArtifact(artifacts: [Artifact], build: Build, completion: @escaping (Error?) -> Void) {
        for artifact in artifacts {
            if artifact.artifactType == "ios-ipa" {
                downloadGroup.enter()
                build.version = artifact.artifactMeta?.appInfo.version
                NetworkService.downloadArtifact(buildSlug: build.slug, artifactSlug: artifact.slug) { (result) in
                    switch result {
                    case .failure(let error):
                        self.downloadGroup.leave()
                        completion(error)
                    case .success(let data):
                        guard let rawResponse = AppRawResponse.decode(data: data) else {
                            self.downloadGroup.leave()
                            completion(DecodeError.RawResponseFail)
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
