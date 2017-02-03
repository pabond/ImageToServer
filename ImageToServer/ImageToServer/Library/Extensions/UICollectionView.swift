//
//  UICollectionView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/5/16.
//  Copyright © 2016 Pavel Bondar. All rights reserved.
//

import UIKit

extension UICollectionView {
    func cellWithClass(_ cls: AnyClass, for indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell?
        cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cls.self), for: indexPath)
            if (cell == nil) {
                cell = UINib.objectWithClass(cls) as? UICollectionViewCell
            }
    
        return cell!
    }

    func registerCell(withClass cls: AnyClass?) {
        cls.map { self.register(UINib.nibWithClass($0), forCellWithReuseIdentifier: String(describing: $0.self)) }
    }
    
    func registerCells(withClasses classes: [AnyClass]?) {
        if classes == nil {
            return
        }
        
        for cls in classes! {
            self.registerCell(withClass: cls)
        }
    }
}
