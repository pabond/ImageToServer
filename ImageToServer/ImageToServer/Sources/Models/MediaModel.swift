//
//  MediaModel.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/14/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class MediaModel: NSObject {
    var progress: Double = 0
    var assetID: String?
    var image: UIImage?
    
    init(assetID: String?, image: UIImage) {
        super.init()
        
        self.assetID = assetID
        self.image = image
    }
}
