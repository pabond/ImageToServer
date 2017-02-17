//
//  FilesToCloudContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class FilesToCloudContext: Context {
    var sessionID: String?
    var session: DBSession?
    
    class func uploadContext(_ session: DBSession) -> FilesToCloudContext {
        var cls: FilesToCloudContext.Type
        
        switch session.cloudType! {
        case CloudType.box.rawValue:
            cls = BoxUploadContext.self
        case CloudType.iCloud.rawValue:
            cls = ICloudUploadContext.self
        case CloudType.mailRuCloud.rawValue:
            cls = MailRuUploadContext.self
        default:
            cls = DropboxUploadContext.self
        }
        
        return cls.init(session: session)
    }
    
    required init(session: DBSession) {
        super.init()
        
        self.session = session
        self.sessionID = session.id
    }
}
