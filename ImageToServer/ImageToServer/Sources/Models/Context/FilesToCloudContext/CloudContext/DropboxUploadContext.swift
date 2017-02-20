//
//  DropboxUploadContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/10/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import SwiftyDropbox

class DropboxUploadContext: FilesToCloudContext {
    
    override func execute() {
        if session?.progress == 1 {
            return
        }
        
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let session = session, let mediaModels = session.mediaModels, let ID = sessionID else { return }
        let models = mediaModels.allObjects
        for i in 0..<models.count {
            guard let mediaModel = models[i] as? DBMediaModel, let model = mediaModel.image else { break }
            guard let data = UIImageJPEGRepresentation(model, 600) else { return }
            
            if mediaModel.progress != 1 {
                _ = cli.files.upload(path: "/myPhotos/\(NSDate())\(ID)\(i).jpeg", input: data)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                        
                        session.progressChange(progressData.fractionCompleted, forItem: i)
                }
            }
        }
    }
}

//in case you want to cancel the request
//if Bool {
//    request.cancel()
//}
