//
//  UINavigationController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/9/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        transitionFlow(block: {
            self.popViewController(animated: true)
        }, completion: completion)
    }
    
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        transitionFlow(block: {
            self.pushViewController(viewController, animated: true)
        }, completion: completion)
    }
    
    func transitionFlow(block: () -> (),completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        block()
        CATransaction.commit()
    }
}
