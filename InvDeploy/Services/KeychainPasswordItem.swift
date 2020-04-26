//
//  KeychainPasswordItem.swift
//  InvDeploy
//
//  Created by Yishai Roodyn on 20/04/2020.
//  Copyright © 2020 Yishai Roodyn. All rights reserved.
//

import Foundation
import Foundation
import LocalAuthentication

struct KeychainPasswordItem {
    // MARK: Types

    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case userCanceled
        case authenticationFailed
        case unhandledError(status: OSStatus)
    }

    // MARK: Properties

    let service: String

    private(set) var account: String

    let accessGroup: String?

    // MARK: Intialization

    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }

    // MARK: Keychain access

    func readPassword() throws -> String {
        /*
         Build a query to find the item that matches the service, account and
         access group.
         */
        var query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue


        // Try to fetch the existing keychain item that matches the query.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // Check the return status and throw an error if appropriate.
        guard status != errSecAuthFailed else { throw KeychainError.authenticationFailed }
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status != errSecUserCanceled else { throw KeychainError.userCanceled }
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }

        // Parse the password string from the query result.
        guard let existingItem = queryResult as? [String: AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData, encoding: String.Encoding.utf8)
            else {
                throw KeychainError.unexpectedPasswordData
        }

        return password
    }

    func savePassword(_ password: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!

        var newItem = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        newItem[kSecValueData as String] = encodedPassword as AnyObject?

            var error: Unmanaged<CFError>?
            let sacRef = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                         kSecAttrAccessibleWhenUnlocked,
                                                         [],
                                                         &error)
            newItem[kSecAttrAccessControl as String] = sacRef

        // Add a the new item to the keychain.
        let status = SecItemAdd(newItem as CFDictionary, nil)

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }

    func savePassword(_ password: String, withPasscode passcode: String?) throws {
        // Encode the password into an Data object.
        let encodedPassword = password.data(using: String.Encoding.utf8)!

        var newItem = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        newItem[kSecValueData as String] = encodedPassword as AnyObject?

        if let passcode = passcode {
            var error: Unmanaged<CFError>?
            let sacRef = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                         kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                         [.applicationPassword],
                                                         &error)
            newItem[kSecAttrAccessControl as String] = sacRef
            let localAuthenticationContext = LAContext.init()
            let appPasscode = passcode.data(using: String.Encoding.utf8)!
            localAuthenticationContext.setCredential(appPasscode, type: LACredentialType.applicationPassword)
            newItem[kSecUseAuthenticationContext as String] = localAuthenticationContext
        }

        // Add a the new item to the keychain.
        let status = SecItemAdd(newItem as CFDictionary, nil)

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }

    func saveBiomentricPasscode(_ passcode: String) throws {
        // Encode the password into an Data object.
        let encodedPassword = passcode.data(using: String.Encoding.utf8)!
        var error: Unmanaged<CFError>?
        var sacRef: SecAccessControl?
        if #available(iOS 11.3, *) {
            sacRef = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                         kSecAttrAccessibleWhenUnlockedThisDeviceOnly,
                                                         .biometryCurrentSet,
                                                         &error)
        }

        var newItem = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        newItem[kSecValueData as String] = encodedPassword as AnyObject?
        newItem[kSecAttrAccessControl as String] = sacRef

        // Add a the new item to the keychain.
        let status = SecItemAdd(newItem as CFDictionary, nil)

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }

    func updatePassword(_ password: String, withPasscode passcode: String?) throws {
        let encodedPassword = password.data(using: String.Encoding.utf8)!
        // Update the existing item with the new password.
        var attributesToUpdate = [String: AnyObject]()
        attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?

        var query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        if let passcode = passcode {
            var error: Unmanaged<CFError>?
            let sacRef = SecAccessControlCreateWithFlags(kCFAllocatorDefault,
                                                         kSecAttrAccessibleWhenUnlocked,
                                                         .applicationPassword,
                                                         &error)
            query[kSecAttrAccessControl as String] = sacRef
            let localAuthenticationContext = LAContext.init()
            let appPasscode = passcode.data(using: String.Encoding.utf8)!
            localAuthenticationContext.setCredential(appPasscode, type: LACredentialType.applicationPassword)
            query[kSecUseAuthenticationContext as String] = localAuthenticationContext
        }

        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }
    }

    mutating func renameAccount(_ newAccountName: String) throws {
        // Try to update an existing item with the new account name.
        var attributesToUpdate = [String: AnyObject]()
        attributesToUpdate[kSecAttrAccount as String] = newAccountName as AnyObject?

        let query = KeychainPasswordItem.keychainQuery(withService: service, account: self.account, accessGroup: accessGroup)
        let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }

        self.account = newAccountName
    }

    func deleteItem() throws {
        // Delete the existing item from the keychain.
        let query = KeychainPasswordItem.keychainQuery(withService: service, account: account, accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)

        // Throw an error if an unexpected status was returned.
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }

    static func passwordItems(forService service: String, accessGroup: String? = nil) throws -> [KeychainPasswordItem] {
        // Build a query for all items that match the service and access group.
        var query = KeychainPasswordItem.keychainQuery(withService: service, accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitAll
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanFalse

        // Fetch matching items from the keychain.
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))
        }

        // If no items were found, return an empty array.
        guard status != errSecItemNotFound else { return [] }

        // Throw an error if an unexpected status was returned.
        guard status == noErr else { throw KeychainError.unhandledError(status: status) }

        // Cast the query result to an array of dictionaries.
        guard let resultData = queryResult as? [[String: AnyObject]] else { throw KeychainError.unexpectedItemData }

        // Create a `KeychainPasswordItem` for each dictionary in the query result.
        var passwordItems = [KeychainPasswordItem]()
        for result in resultData {
            guard let account  = result[kSecAttrAccount as String] as? String else { throw KeychainError.unexpectedItemData }

            let passwordItem = KeychainPasswordItem(service: service, account: account, accessGroup: accessGroup)
            passwordItems.append(passwordItem)
        }

        return passwordItems
    }

    // MARK: Convenience

    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?

        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }

        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }

        return query
    }
}
