//
//  OnboardingService.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 21/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation

enum OnboardingService {

    static func validateAPIKey(_ key: String) -> Bool {
        if key.count > 10 {
            return true
        }
        return false
    }
}
