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
    var imagePeackView: ImagePeackView?
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePeackView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
        imagePeackView = viewGetter()
        allImages()
    }

    func allImages () {
        let imageManager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        if fetchResult.count > 0 {
            for i in 0..<fetchResult.count {
                let img: PHAsset! = fetchResult.object(at: i) as PHAsset
                imageManager.requestImage(for: img, targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: requestOptions, resultHandler: { [weak self] image, error in
                    image.map{ self?.images.append($0) }
                })
            }
        } else {
            print("you have no photos")
            imagePeackView?.collectionView.reloadData()
        }
    }
}

extension ImagePeackViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as? ImageCollectionViewCell
        cell?.object = images[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
