//
//  DBMediaModel+CoreDataClass.swift
//  
//
//  Created by Pavel Bondar on 2/15/17.
//
//

import Foundation
import CoreData


public class DBMediaModel: NSManagedObject {
    var image: UIImage? {
        return imageData.map { UIImage(data: $0 as Data) } ?? nil
    }
    
    class func MediaModel(assetID: String?, data: Data) -> DBMediaModel? {
        let mediaModel = DBMediaModel.mr_createEntity()
        mediaModel?.assetID = assetID
        mediaModel?.imageData = data as NSData?
        
        return mediaModel
    }
}
