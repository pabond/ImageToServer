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
    let observable = PublishSubject<[MediaModel]>()
    
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
        return CGSize(width: 600, height: 600)
    }
    
    var sortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "creationDate", ascending: true)]
    }
    
    override func execute() {
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if fetchResult.count > 0 {
            var mediaModels = [MediaModel]()
            
            for i in 0..<fetchResult.count {
                let asset: PHAsset! = fetchResult.object(at: i) as PHAsset
                imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions, resultHandler: { image, error in
                    image.map{ mediaModels.append(MediaModel(assetID: asset.localIdentifier, image: $0)) }
                })
            }
            
            observable.onNext(mediaModels)
        } else {
            print("you have no photos")
        }
    }
}
