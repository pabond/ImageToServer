//
//  ViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

fileprivate let inset: CGFloat = 3.0
fileprivate let cellsPerRow: CGFloat = 4

class ImagePeackViewController: UIViewController {
    var startSending: ((_ cloudType: CloudType, _ images: ArrayModel?) -> ())?
    let disposeBag = DisposeBag()
    var imagePeackView: ImagePeackView?
    var images: [UIImage]?
    var pickedImages = ArrayModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePeackView = viewGetter()
        imagePeackView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
        allImages()
    }

    func allImages () {
        let context = FetchImagesContext()
        context.observable.subscribe({ [weak self] (images) in
            self?.images = images.element
            DispatchQueue.main.async { [weak self] () -> Void in
                self?.imagePeackView?.collectionView.reloadData()
            }
        }).addDisposableTo(disposeBag)
        
        DispatchQueue.global().async {
            context.execute()
        }
    }
    
    @IBAction func onStoreToCloud(_ sender: Any) {
        startSending?(.dropBox, pickedImages)
    }
}

extension ImagePeackViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        cell.object = images?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        cell.selectedView.isHidden = false
        pickedImages.addModel(cell.object)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        cell.selectedView.isHidden = true
        pickedImages.removeModel(cell.object)
    }
}

extension ImagePeackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let width = collectionView.frame.width / cellsPerRow - inset
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return inset
    }
}
