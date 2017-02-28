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

class ImagePickViewController: UIViewController, RootViewGettable {
    
    typealias RootViewType = ImagePickView
    
    var prepickedImages: ArrayModel?
    var startSending: ((_ images: ArrayModel?) -> ())?
    fileprivate var mediaModels: [MediaModel]?
    fileprivate var pickedModels = ArrayModel()
    private let disposeBag = DisposeBag()
    
    //MARK: -
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
        navigationItem.title = "Images"
        fetchImages()
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onLoadSetup(_ sender: Any) {
        navigationController?.popViewControllerWithHandler(completion: { [weak self] in
            self?.startSending?(self?.pickedModels)
        })
    }

    //MARK: -
    //MARK: Private functions
    
    private func fetchImages() {
        let context = FetchImagesContext()
        context
            .observable
            .observeOn(MainScheduler.instance)
            .subscribe({ [weak self] (mediaModels) in
            self?.mediaModels = mediaModels.element
            self?.rootView?.collectionView.reloadData()
        }).addDisposableTo(disposeBag)
        
        DispatchQueue.global().async {
            context.execute()
        }
    }
    
    fileprivate func setCellSelected(_ cell: UICollectionViewCell?, at index: Int) {
        guard let cell = cell as? ImageCollectionViewCell else { return }
        cell.selectedImage.isHidden = false
        pickedModels.addModel(mediaModels?[index])
    }
}

//MARK: -
//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension ImagePickViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        let object = mediaModels?[indexPath.row]
        cell.fillWith(object?.image)
        if prepickedImages != nil, prepickedImages?.count != 0, let models = prepickedImages?.models as? [MediaModel] {
            if models.contains(where: { $0.assetID == object?.assetID }) {
                setCellSelected(cell, at: indexPath.row)
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
            } else {
                cell.selectedImage.isHidden = true
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setCellSelected(collectionView.cellForItem(at: indexPath), at: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCollectionViewCell else { return }
        cell.selectedImage.isHidden = true
        pickedModels.removeModel(mediaModels?[indexPath.row])
    }
}

//MARK: -
//MARK: UICollectionViewDelegateFlowLayout

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
