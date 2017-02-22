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
    fileprivate var requests = [UploadRequest<Files.FileMetadataSerializer, Files.UploadErrorSerializer>]()
    
    override func execute() {
        if session?.progress == 1 {
            session?.sessionState = .sessionDidLoad
            
            return
        }
        
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let session = session, let mediaModels = session.mediaModels, let ID = sessionID else { return }
        session.sessionState = .sessionWillLoad
        
        let models = mediaModels.allObjects
        for i in 0..<models.count {
            guard let mediaModel = models[i] as? DBMediaModel, let model = mediaModel.image else { break }
            guard let data = UIImageJPEGRepresentation(model, 600) else { return }
            
            if mediaModel.progress != 1 {
                let request = cli.files.upload(path: "/myPhotos/\(NSDate())\(ID)\(i).jpeg", input: data)
                    .response { response, error in
                        if let response = response {
                            print(response)
                        } else if let error = error {
                            session.sessionState = .sessionFailLoading
                            print(error)
                        }
                    }
                    .progress { progressData in
                        print(progressData)
                        
                        session.progressChange(progressData.fractionCompleted, forItem: i)
                }
                
               requests.append(request)
                
                if session.shouldStopLoading {
                    return
                }
            }
        }
    }
    
    override func cancelLoading() {
        requests.forEach { $0.cancel() }
    }
}
