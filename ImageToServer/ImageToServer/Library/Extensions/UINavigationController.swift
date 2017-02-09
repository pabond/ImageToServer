//
//  UINavigationController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/9/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

extension UINavigationController {
    //Same function as "popViewController", but allow us to know when this function ends
    func popViewControllerWithHandler(completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.popViewController(animated: true)
        CATransaction.commit()
    }
    func pushViewController(viewController: UIViewController, completion: @escaping ()->()) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
}
