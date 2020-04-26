//
//  KeychainPassword.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation
import LocalAuthentication

struct KeychainConfiguration {
    static let serviceName = "InvDeploy"
    static let accessGroup: String? = nil
    static let username: String = "InvUsername"
}

class KeychainService {

    class func loadPassword() throws -> String {
        guard let uuid = uuidString(forKey: KeychainConfiguration.username) else {
            throw KeychainPasswordItem.KeychainError.unexpectedItemData
        }
        do {
            let username = KeychainConfiguration.username + uuid
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username,
                                                    accessGroup: KeychainConfiguration.accessGroup)
            let keychainPassword = try passwordItem.readPassword()
            return keychainPassword
        } catch KeychainPasswordItem.KeychainError.userCanceled {
            throw KeychainPasswordItem.KeychainError.userCanceled

        } catch KeychainPasswordItem.KeychainError.authenticationFailed {
                throw KeychainPasswordItem.KeychainError.authenticationFailed
        } catch {
            fatalError("Error reading password from keychain - \(error)")
        }
    }

    class func savePassword(_ password: String?) {
        guard let password = password else { return }
        let uuid = KeychainService.createUUID(withKey: KeychainConfiguration.username)
        let username = KeychainConfiguration.username + uuid
        deletePassword(username: username)
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username)
            try passwordItem.savePassword(password)
        } catch {
            fatalError("Error updating keychain - \(error)")
        }
    }

    class func deletePassword(username: String?) {
        guard let username = username else { return }
        do {
            let passwordItem = KeychainPasswordItem(service: KeychainConfiguration.serviceName,
                                                    account: username)

            try passwordItem.deleteItem()
        } catch {
            fatalError("Error deleting from keychain - \(error)")
        }
    }

    static func createUUID(withKey key: String) -> String {
        let uuid = UUID().uuidString
        UserDefaults.standard.set(uuid, forKey: key)
        return uuid
    }

    static func uuidString(forKey key: String) -> String? {
        return UserDefaults.standard.string(forKey: key)
    }
}
