//
//  NetworkService.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 19/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

typealias StringAnyDictionary = [String: Any]

enum NetworkError: Error {
    case Unknown
    case UnAuthorized
    case BadData
}

enum NetworkService {
    static func downloadBuilds(urlSession: URLSession = URLSession(configuration: .default), completion: @escaping (Result<Data,Error>)->Void) {
        guard var urlComponents = URLComponents(string: "https://api.bitrise.io/v0.1/apps/f3f95d514f0229b3/builds") else { return }
        urlComponents.queryItems = [
            URLQueryItem(name: "trigger_event_type", value: "pull-request"),
            URLQueryItem(name: "limit", value: "25"),
            URLQueryItem(name: "status", value: "1")
        ]
        guard let url = urlComponents.url else { return }
        var request = URLRequest(url: url)
        addAuthorizationHeader(&request)
        getRequest(request, session: urlSession) { (result)  in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }

    static func downloadArtifactList(urlSession: URLSession = URLSession(configuration: .default), buildSlug: String, completion: @escaping (Result<Data,Error>)->Void) {
        guard let url = URL(string: "https://api.bitrise.io/v0.1/apps/f3f95d514f0229b3/builds/\(buildSlug)/artifacts") else { return }
        var request = URLRequest(url: url)
        addAuthorizationHeader(&request)
        getRequest(request, session: urlSession) { (result)  in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }

    static func downloadArtifact(urlSession: URLSession = URLSession(configuration: .default), buildSlug: String, artifactSlug: String, completion: @escaping (Result<Data,Error>)->Void) {
        guard let url = URL(string: "https://api.bitrise.io/v0.1/apps/f3f95d514f0229b3/builds/\(buildSlug)/artifacts/\(artifactSlug)") else { return }
        var request = URLRequest(url: url)
        addAuthorizationHeader(&request)
        getRequest(request, session: urlSession) { (result)  in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                completion(.success(data))
            }
        }
    }

    private static func addAuthorizationHeader( _ request: inout URLRequest) {
        let apiKey = try? KeychainService.loadPassword()
        request.addValue(apiKey ?? "", forHTTPHeaderField: "Authorization")
    }

    private static func getRequest(_ request: URLRequest, session: URLSession, completion: @escaping (Result<Data,Error>)->Void)  {
        session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 401 {
                    completion(.failure(NetworkError.UnAuthorized))
                }
                if let data = data, response.statusCode == 200 {
                    DispatchQueue.main.async {
                        completion(.success(data))
                    }
                }
            } else {
                completion(.failure(NetworkError.Unknown))
            }
        }.resume()
    }
}
