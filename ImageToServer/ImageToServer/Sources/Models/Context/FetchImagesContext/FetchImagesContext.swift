//
//  FetchImagesContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift
import Photos

class FetchImagesContext: Context {
    let observable = PublishSubject<[UIImage]>()
    
    var imageManager: PHImageManager {
        return PHImageManager.default()
    }
    
    var requestOptions: PHImageRequestOptions {
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = deliveryMode
        
        return requestOptions
    }
    
    var deliveryMode: PHImageRequestOptionsDeliveryMode {
        return .highQualityFormat
    }
    
    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = sortDescriptors
        
        return fetchOptions
    }
    
    var size: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    var sortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "creationDate", ascending: true)]
    }
    
    override func execute() {
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if fetchResult.count > 0 {
            var images = [UIImage]()
            for i in 0..<fetchResult.count {
                let img: PHAsset! = fetchResult.object(at: i) as PHAsset
                imageManager.requestImage(for: img, targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { image, error in
                    image.map{ images.append($0) }
                })
            }
            
            observable.onNext(images)
        } else {
            print("you have no photos")
        }
    }
}
