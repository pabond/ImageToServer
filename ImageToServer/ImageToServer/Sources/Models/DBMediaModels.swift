//
//  DBMediaModels.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/15/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let entityesName = "DBMediaModel"
fileprivate let key = "assetID"

class DBMediaModels: DBArrayModel {
    override var entityName: String {
        return entityesName
    }
    
    override var predicate: NSPredicate? {
        if keyPath != nil && self.object != nil {
            return NSPredicate(format: "session == %@", argumentArray: [object as! DBSession])
        }
            
        return super.predicate
    }
    
    override var sortDesriptor: NSSortDescriptor {
        return NSSortDescriptor(key: key, ascending: true)
    }
}
