//
//  DBSession+CoreDataProperties.swift
//  
//
//  Created by Pavel Bondar on 2/15/17.
//
//

import Foundation
import CoreData


extension DBSession {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBSession> {
        return NSFetchRequest<DBSession>(entityName: "DBSession");
    }

    @NSManaged public var id: String?
    @NSManaged public var cloudType: String?
    @NSManaged public var mediaModels: NSOrderedSet?

}

// MARK: Generated accessors for mediaModels
extension DBSession {

    @objc(insertObject:inMediaModelsAtIndex:)
    @NSManaged public func insertIntoMediaModels(_ value: DBMediaModel, at idx: Int)

    @objc(removeObjectFromMediaModelsAtIndex:)
    @NSManaged public func removeFromMediaModels(at idx: Int)

    @objc(insertMediaModels:atIndexes:)
    @NSManaged public func insertIntoMediaModels(_ values: [DBMediaModel], at indexes: NSIndexSet)

    @objc(removeMediaModelsAtIndexes:)
    @NSManaged public func removeFromMediaModels(at indexes: NSIndexSet)

    @objc(replaceObjectInMediaModelsAtIndex:withObject:)
    @NSManaged public func replaceMediaModels(at idx: Int, with value: DBMediaModel)

    @objc(replaceMediaModelsAtIndexes:withMediaModels:)
    @NSManaged public func replaceMediaModels(at indexes: NSIndexSet, with values: [DBMediaModel])

    @objc(addMediaModelsObject:)
    @NSManaged public func addToMediaModels(_ value: DBMediaModel)

    @objc(removeMediaModelsObject:)
    @NSManaged public func removeFromMediaModels(_ value: DBMediaModel)

    @objc(addMediaModels:)
    @NSManaged public func addToMediaModels(_ values: NSOrderedSet)

    @objc(removeMediaModels:)
    @NSManaged public func removeFromMediaModels(_ values: NSOrderedSet)

}
