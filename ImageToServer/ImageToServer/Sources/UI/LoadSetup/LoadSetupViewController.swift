//
//  LoadSetupViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/7/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let inset: CGFloat = 3.0
fileprivate let cellsPerRow: CGFloat = 4

fileprivate let alertNoNameTitle = "Name not set"
fileprivate let alertNoNameText = "Please input pakage to send name"
fileprivate let addImageName = "AddImage"
fileprivate let alertNotSelectedImages = "Images not selected"
fileprivate let alertNotSelectedImagesText = "Please select some pictures to send"

class LoadSetupViewController: ViewController {
    var startLoading: (( _ session: DBSession) -> ())?
    var loadSetupView: LoadSetupView?
    var mediaModels: ArrayModel?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSetupView = viewGetter()
        loadSetupView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
    }
    
    @IBAction func onSend(_ sender: Any) {
        let title = loadSetupView?.nameTextField.text
        
        guard title != nil || title != "" else { infoAlert(title: alertNoNameTitle, text: alertNoNameText); return }
        guard mediaModels?.count != 0 else { infoAlert(title: alertNotSelectedImages, text: alertNotSelectedImagesText); return }
        
        navigationController?.popViewControllerWithHandler { [weak self] in
            guard let cloud = self?.loadSetupView?.selectedCloud, let mediaModels = self?.mediaModels  else { return }
            
            let session = DBSession.session(title!, cloud)
            session?.mediaModelsList?.addModels(mediaModels.models)
            guard let ses = session, let loadFunc = self?.startLoading else { return }
            loadFunc(ses)
        }
    }
    
    func imagesAdded(_ mediaModels: ArrayModel?) {
        self.mediaModels = mediaModels
        loadSetupView?.collectionView.reloadData()
    }
}

extension LoadSetupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mediaModels?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        let index = indexPath.row
        var object: UIImage?
        if mediaModels != nil, index < (mediaModels?.count)!, let image = mediaModels?[index].image {
            object = image
        } else {
            object = #imageLiteral(resourceName: "AddImage")
        }
        
        cell.object = object
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (mediaModels?.count ?? 0) {
            let vc = instantiateViewControllerOnMain(withClass: ImagePickViewController.self)
            vc?.startSending = imagesAdded
            mediaModels.map { vc?.pickedModels = $0 }
            vc.map { navigationController?.pushViewController($0, animated: true) }
        }
    }
}

extension LoadSetupViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let height = collectionView.frame.height
        
        return CGSize(width: height, height: height)
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
