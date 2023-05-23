//
//  BasePresenter.swift
//  msd_sdk
//
//  Created by Julien on 22/05/23.
//

import Foundation

class BasePresenter {
    
    fileprivate func getMadUUID() -> String {
        if let uuid = UserDefaults.standard.getUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue), !uuid.isEmpty {
            return uuid
        }
        let generatedUUID = UUID().uuidString
        UserDefaults.standard.setUserDefaultString(key: UserDefaultsKeys.MAD_UUID.rawValue, value: generatedUUID)
        return generatedUUID
    }
}

