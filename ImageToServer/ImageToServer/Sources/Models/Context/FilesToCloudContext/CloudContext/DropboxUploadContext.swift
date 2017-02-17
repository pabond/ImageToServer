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
    
    //var progressHandler: ((_ progressData: Double, _ sessionID: String, _ itemID: Int) -> ())?
    
    override func execute() {
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client else { return }
        guard let session = session else { return }
        guard let mediaModels = session.mediaModelsList else { return }
        guard let ID = sessionID else { return }
        let count = mediaModels.count
        for i in 0..<count {
            guard let mediaModel = mediaModels[i] as? DBMediaModel else { break }
//            guard let model = mediaModel.image else { return }
//            guard let data = UIImageJPEGRepresentation(model, 600)  else { return }
            
            guard let data = mediaModel.imageData as? Data, let assetID = mediaModel.assetID else { return }
            _ = cli.files.upload(path: "/myPhotos/\(assetID)\(ID)\(i).jpeg", input: data)
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

//in case you want to cancel the request
//if Bool {
//    request.cancel()
//}
