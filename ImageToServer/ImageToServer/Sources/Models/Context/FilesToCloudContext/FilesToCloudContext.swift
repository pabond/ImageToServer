//
//  FilesToCloudContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class FilesToCloudContext: Context {
    var objectsToLoad: ArrayModel?
    var sessionID: String?
    
    class func uploadContext(objects: ArrayModel, sessionID: String?, cloudType: CloudType) -> FilesToCloudContext {
        var cls: FilesToCloudContext.Type
        switch cloudType {
        case CloudType.box:
            cls = BoxUploadContext.self
        case CloudType.iCloud:
            cls = ICloudUploadContext.self
        case CloudType.mailRuCloud:
            cls = MailRuUploadContext.self
        default:
            cls = DropboxUploadContext.self
        }
        
        return cls.init(objects: objects, sessionID: sessionID)
    }
    
    required init(objects: ArrayModel, sessionID: String?) {
        super.init()
        
        objectsToLoad = objects
        self.sessionID = sessionID
    }
}
