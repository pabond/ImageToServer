//
//  DBSessions.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/15/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let entityesName = "DBSession"
fileprivate let key = "id"

class DBSessions: DBArrayModel {
    override var entityName: String {
        return entityesName
    }
    
    override var predicate: NSPredicate? {
        if keyPath != nil && self.object != nil {
            return NSPredicate(format: "identifier == %@", argumentArray: [1])
        }
            
        return super.predicate
    }
    
    override var sortDesriptor: NSSortDescriptor {
        return NSSortDescriptor(key: key, ascending: true)
    }
}
