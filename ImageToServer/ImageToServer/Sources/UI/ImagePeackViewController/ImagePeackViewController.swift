//
//  ViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import Photos

class ImagePeackViewController: UIViewController {
    
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func allImages () {
        let imageManager = PHImageManager.defaultManager()
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = false
        requestOptions.deliveryMode = .HighQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        if let fetchResult: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions) {
            if fetchResult.count > 0 {
                for i in 0..<fetchResult.count {
                    let img: PHAsset! = fetchResult.objectAtIndex(i) as PHAsset
                    imageManager.requestImageForAsset(img, targetSize: CGSize(width: 200, height: 200), contentMode: .AspectFill, options: requestOptions, resultHandler: { [weak self] image, error in
                        image.map{ self?.images.append($0) }
                    })
                }
                
            } else {
                print("you have no photos")
            }
        }
    }
}
