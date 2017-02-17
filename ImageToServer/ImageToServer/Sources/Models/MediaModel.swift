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
    var image: UIImage? {
        return imageData.map { UIImage(data: $0) } ?? nil
    }
    
    var imageData: Data?
    
    init(assetID: String?, data: Data) {
        self.assetID = assetID
        self.imageData = data as Data
    }
}
