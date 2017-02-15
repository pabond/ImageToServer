//
//  DBMediaModel+CoreDataProperties.swift
//  
//
//  Created by Pavel Bondar on 2/15/17.
//
//

import Foundation
import CoreData


extension DBMediaModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMediaModel> {
        return NSFetchRequest<DBMediaModel>(entityName: "DBMediaModel");
    }

    @NSManaged public var imageData: NSData?
    @NSManaged public var progress: Double
    @NSManaged public var assetID: String?
    @NSManaged public var session: DBSession?

}
