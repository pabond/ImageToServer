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
    
    var progressHandler: ((_ progressData: Double, _ sessionID: String, _ itemID: Int) -> ())?
    
    override func execute() {
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let models = objectsToLoad, let ID = sessionID else { return }
        for i in 0..<models.count {
            guard let model = objectsToLoad?[i] as? UIImage else { break }
            guard let data = UIImageJPEGRepresentation(model, 200)  else { return }
            
            _ = cli.files.upload(path: "/myPhotos/\(NSDate())\(ID)\(i).jpeg", input: data)
                .response { response, error in
                    if let response = response {
                        print(response)
                    } else if let error = error {
                        print(error)
                    }
                }
                .progress { [weak self] progressData in
                    print(progressData)
                    
                    self?.progressHandler.map { $0(progressData.fractionCompleted, ID, i) }
            }
        }
        
        // in case you want to cancel the request
        //        if Bool {
        //            request.cancel()
        //        }
    }
}
