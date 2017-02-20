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
        return imageURL.map { UIImage(contentsOfFile: $0) } ?? nil
    }
    
    class func MediaModel(assetID: String?, imageURL: String) -> DBMediaModel? {
        let mediaModel = DBMediaModel.mr_createEntity()
        mediaModel?.assetID = assetID
        mediaModel?.imageURL = imageURL
        
        return mediaModel
    }
}
