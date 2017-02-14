//
//  UIViewController.swift
//  RecipesList
//
//  Created by Bondar Pavel on 11/16/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit
import Foundation

fileprivate let storiboardMain = "Main"
fileprivate let OKTitle = "OK"

extension UIViewController {
    func viewGetter<V>() -> V? {
        return self.viewIfLoaded.flatMap({$0 as? V})
    }
    
    var isRegularWidthAndRegularHeight: Bool {
        let sizeClass = self.traitCollection
        return sizeClass.verticalSizeClass == .regular && sizeClass.horizontalSizeClass ==  .regular
    }
    
    var isRegularWidth: Bool {
        return self.traitCollection.horizontalSizeClass ==  .regular
    }
    
    var isRegularWidthOrCompactWidthAndCompactHeight: Bool {
        return isRegularWidth || isCompactWidthAndCompactHeight
    }
    
    var isCompactWidthAndCompactHeight: Bool {
        let sizeClass = self.traitCollection
        
        return sizeClass.verticalSizeClass == .compact && sizeClass.horizontalSizeClass ==  .compact
    }
    
    class func viewController() -> UIViewController {
        return self.init(nibName:nibName(), bundle:nil)
    }
    
    class func nibName() -> String {
        return  String(describing: self)
    }

    func performSegue(toViewControllerWithClass cls: AnyClass, sender: Any?) {
        performSegue(withIdentifier: String(describing: cls.self), sender: sender)
    }
    
    func infoAlert(title: String, text: String) {
        let alertController = UIAlertController(title: title,
                                                message: text,
                                                preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: OKTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func popCurrentViewController() {
        _ = navigationController?.popViewController(animated: true)
    }
    
    func instantiateViewControllerOnMain<T>(withClass cls: T.Type) -> T? {
        return instantiateViewController(withClass: cls, on: storiboardMain)
    }
    
    func instantiateViewController<T>(withClass cls: T.Type, on storyboardName: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as? T
    }
}
