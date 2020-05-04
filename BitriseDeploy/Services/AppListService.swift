//
//  AppListService.swift
//  BitriseDeploy
//
//  Created by Yishai Roodyn on 04/05/2020.
//  Copyright © 2020 Yishai R. All rights reserved.
//

import Foundation

enum AppListService {
    
    static func downloadIOSAppList(completion: @escaping (Result<[App], Error>) -> Void) {
        NetworkService.downloadAppsList { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let rawResponse = AppsListRawResponse.decode(data: data) else {
                completion(.failure(BuildServiceError.RawResponseFail))
                return
                }
                let filteredList = rawResponse.data.filter { $0.projectType == "ios" }
                completion(.success(filteredList))
            }
        }
    }
}
