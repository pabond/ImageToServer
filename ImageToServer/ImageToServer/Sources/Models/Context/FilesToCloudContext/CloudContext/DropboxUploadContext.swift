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
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let models = objectsToLoad else { return }
        for i in 0..<models.count {
            guard let model = objectsToLoad?[i] as? UIImage else { break }
            guard let data = UIImageJPEGRepresentation(model, 200), let ID = sessionID  else { return }
            
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
            }
        }
        
        // in case you want to cancel the request
        //        if Bool {
        //            request.cancel()
        //        }
    }
}
