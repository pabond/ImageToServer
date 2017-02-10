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

fileprivate let alertTitle = "No pictures picked"
fileprivate let alertText = "Please pick some images to send first"

class ImagePickViewController: UIViewController {
    var startSending: ((_ images: ArrayModel?) -> ())?
    let disposeBag = DisposeBag()
    var imagePickView: ImagePickView?
    var images: [UIImage]?
    var pickedImages = ArrayModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePickView = viewGetter()
        imagePickView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
        allImages()
    }

    func allImages () {
        let context = FetchImagesContext()
        context.observable.subscribe({ [weak self] (images) in
            self?.images = images.element
            DispatchQueue.main.async { [weak self] () -> Void in
                self?.imagePickView?.collectionView.reloadData()
            }
        }).addDisposableTo(disposeBag)
        
        DispatchQueue.global().async {
            context.execute()
        }
    }
    
    @IBAction func onLoadSetup(_ sender: Any) {
        navigationController?.popViewControllerWithHandler(completion: { [weak self] in
            self?.startSending?(self?.pickedImages)
        })
    }
    
    func setCellSelected(_ cell: ImageCollectionViewCell) {
        cell.selectedImage.isHidden = false
    }
}

extension ImagePickViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        let object = images?[indexPath.row]
        cell.object = object
        if pickedImages.count != 0 && pickedImages.containsModel(object) {
            setCellSelected(cell)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        setCellSelected(cell)
        pickedImages.addModel(cell.object)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        cell.selectedImage.isHidden = true
        pickedImages.removeModel(cell.object)
    }
}

extension ImagePickViewController: UICollectionViewDelegateFlowLayout {
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
