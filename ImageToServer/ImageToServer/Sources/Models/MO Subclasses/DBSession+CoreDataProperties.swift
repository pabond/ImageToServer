//
//  DBSession+CoreDataProperties.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/17/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData


extension DBSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSession> {
        return NSFetchRequest<DBSession>(entityName: "DBSession");
    }

    @NSManaged public var cloudType: String?
    @NSManaged public var id: String?
    @NSManaged public var identifier: Int16
    @NSManaged public var mediaModels: NSSet?

}

// MARK: Generated accessors for mediaModels
extension DBSession {

    @objc(addMediaModelsObject:)
    @NSManaged public func addToMediaModels(_ value: DBMediaModel)

    @objc(removeMediaModelsObject:)
    @NSManaged public func removeFromMediaModels(_ value: DBMediaModel)

    @objc(addMediaModels:)
    @NSManaged public func addToMediaModels(_ values: NSSet)

    @objc(removeMediaModels:)
    @NSManaged public func removeFromMediaModels(_ values: NSSet)

}
