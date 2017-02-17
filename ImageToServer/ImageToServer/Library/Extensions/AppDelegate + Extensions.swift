//
//  AppDelegate + Extensions.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/9/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import MagicalRecord
import SwiftyDropbox

//fileprivate let storeName = "Sessions.store"

extension AppDelegate {
    func magicalRecordSetup() {
        MagicalRecord.enableShorthandMethods()
        MagicalRecord.setupCoreDataStack(withStoreNamed: "Sessions.store")
    }
    
    func save() {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore { (saved, error) in
            if !saved {
                print(error ?? "")
            }
        }
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if let authResult = DropboxClientsManager.handleRedirectURL(url) {
            switch authResult {
            case .success:
                print("Success! User is logged into Dropbox.")
            case .cancel:
                print("Authorization flow was manually canceled by user!")
            case .error(_, let description):
                print("Error: \(description)")
            }
        }
        
        return true
    }
}
