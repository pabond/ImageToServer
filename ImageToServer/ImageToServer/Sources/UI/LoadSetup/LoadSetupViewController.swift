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

class LoadSetupViewController: ViewController {
    var startLoading: ((_ images: ArrayModel?) -> ())?
    var loadSetupView: LoadSetupView?
    var images: ArrayModel?
    let clouds = ["Dropbox", "Box", "Google Drive", "iCloud", "MailRu Cloud"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSetupView = viewGetter()
        loadSetupView?.collectionView.registerCell(withClass: ImageCollectionViewCell.self)
    }
    
    @IBAction func onSend(_ sender: Any) {
        navigationController?.popViewControllerWithHandler { [weak self] in
            self?.startLoading.map { $0(self?.images) }
        }
    }
    
    func imagesAdded(_ images: ArrayModel?) {
        self.images = images
        loadSetupView?.collectionView.reloadData()
    }
}

extension LoadSetupViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return clouds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return clouds[row]
    }
}

extension LoadSetupViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (images?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cellWithClass(ImageCollectionViewCell.self, for: indexPath) as! ImageCollectionViewCell
        let index = indexPath.row
        var object: UIImage?
        if images != nil, index < (images?.count)!, let image = images?[index] as? UIImage {
            object = image
        } else {
            object = UIImage(named: "AddImage")
        }
        
        cell.object = object
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == (images?.count ?? 0) {
            let vc = instantiateViewController(withClass: ImagePeackViewController.self)
            vc?.startSending = imagesAdded
            images.map { vc?.pickedImages = $0 }
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
