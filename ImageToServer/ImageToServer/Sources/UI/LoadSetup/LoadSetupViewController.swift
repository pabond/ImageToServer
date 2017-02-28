//
//  LoadSetupViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/7/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate struct AlertConstants {
    static let alertNoNameTitle = "Name not set"
    static let alertNoNameText = "Please input session name to send"
    static let alertNotSelectedImages = "Images not selected"
    static let alertNotSelectedImagesText = "Please select some pictures to send"
}

class LoadSetupViewController: ViewController, RootViewGettable {
    
    typealias RootViewType = LoadSetupView
    
    fileprivate let inset: CGFloat = 3.0
    fileprivate let cellsPerRow: CGFloat = 4
    
    var startLoading: ((_ session: DBSession) -> ())?
    var mediaModels: ArrayModel?
    
    //MARK: -
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        rootView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    
    @IBAction func onCancel(_ sender: Any) {
        popCurrentViewController()
    }
    
    @IBAction func onSend(_ sender: Any) {
        let title = rootView?.nameTextField.text
        
        if title == nil || title == "" {
            infoAlert(title: AlertConstants.alertNoNameTitle, text: AlertConstants.alertNoNameText)
            
            return
        } else if mediaModels?.count == 0 {
            infoAlert(title: AlertConstants.alertNotSelectedImages, text: AlertConstants.alertNotSelectedImagesText)
            
            return
        }
        
        navigationController?.popViewControllerWithHandler { [weak self] in
            guard let cloud = self?.rootView?.selectedCloud, let session = DBSession.session(title!, cloud) else { return }
            let context = SessionFillContext.fillSession(session, with: self?.mediaModels)
            context.execute()
            self?.startLoading.map { $0(session) }
        }
    }
    
    //MARK: -
    //MARK: Private functions
    
    fileprivate func imagesAdded(_ mediaModels: ArrayModel?) {
        self.mediaModels = mediaModels
        rootView?.collectionView.reloadData()
    }
}

//MARK: -
//MARK: UICollectionViewDelegate, UICollectionViewDataSource

extension LoadSetupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mediaModels?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        let index = indexPath.row
        var object: UIImage?
        if mediaModels != nil, index < (mediaModels?.count ?? 0), let image = mediaModels?[index].image {
            object = image
        } else {
            object = #imageLiteral(resourceName: "AddImage")
        }
        
        cell.fillWith(object)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (mediaModels?.count ?? 0) {
            let vc = instantiateViewControllerOnMain(withClass: ImagePickViewController.self)
            vc?.startSending = imagesAdded
            vc?.prepickedImages = mediaModels
            vc.map { navigationController?.pushViewController($0, animated: true) }
        }
    }
}

//MARK: -
//MARK: UICollectionViewDelegateFlowLayout

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
