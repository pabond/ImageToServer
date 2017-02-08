//
//  LoginWithDropbox.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/7/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import SwiftyDropbox

class LoginWithDropbox: LoginContext {
    var controller: UIViewController?
    
    override init() {
        super.init()
        
        self.controller = UIApplication.topViewController()
    }
    
    override func execute() {
        guard let controller = controller else { return }
        DropboxClientsManager.authorizeFromController(UIApplication.shared,
                                                      controller: controller,
                                                      openURL: {    (url: URL) -> Void in
                                                                    UIApplication.shared.openURL(url)
                                                                },
                                                      browserAuth: true)
    }
}
