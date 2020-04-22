//
//  WorkflowService.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 21/04/2020.
//  Copyright © 2020 Investing.com. All rights reserved.
//

import Foundation

enum WorkflowService {
    
    static func downloadWorkflows(completion: @escaping (Result<[String], Error>) -> Void) {
        NetworkService.downloadWorkflows { (result) in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .success(let data):
                guard let workflowList = WorkflowList.decode(data: data) else {
                    completion(.failure(BuildServiceError.RawResponseFail))
                    return
                }
                completion(.success(workflowList.data))
            }
        }
    }
}
