//
//  FilesToCloudContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import SwiftyDropbox
import UIKit

class FilesToCloudContext: Context {
    fileprivate var objectsToLoad: ArrayModel?
    
    init(objects: ArrayModel) {
        super.init()
        
        objectsToLoad = objects
    }
    
    override func execute() {
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let models = objectsToLoad else { return }
        for i in 0..<models.count {
            guard let model = objectsToLoad?[i] as? UIImage else { break }
            guard let data = UIImageJPEGRepresentation(model, 200) else { return }
            _ = cli.files.upload(path: "/myPhotos/\(NSDate()).jpeg", input: data)
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
        //
        
        // in case you want to cancel the request
//        if Bool {
//            request.cancel()
//        }
    }
}
