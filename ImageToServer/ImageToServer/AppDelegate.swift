//
//  AppDelegate.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import SwiftyDropbox

fileprivate let appKey = "3z8hq7rwaeolla2"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    { 
        magicalRecordSetup()
        DropboxClientsManager.setupWithAppKey(appKey)
        
        print(DBSession.mr_findAll() ?? "")
        print(DBMediaModel.mr_findAll() ?? "")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        save()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        save()
    }
}

