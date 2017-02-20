//
//  DBMediaModel+CoreDataProperties.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/20/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation
import CoreData


extension DBMediaModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBMediaModel> {
        return NSFetchRequest<DBMediaModel>(entityName: "DBMediaModel");
    }

    @NSManaged public var assetID: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var progress: Double
    @NSManaged public var session: DBSession?

}
