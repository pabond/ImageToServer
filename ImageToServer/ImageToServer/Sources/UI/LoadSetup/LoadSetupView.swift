//
//  LoadSetupView.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/8/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class LoadSetupView: UIView {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var cloudPickerView: UIPickerView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let clouds = ["Dropbox", "Box", "iCloud", "MailRu Cloud", "Google Drive"]
    var selectedCloud: CloudType {
        var cloud: CloudType
        switch cloudPickerView.selectedRow(inComponent: 0) {
        case 1:
            cloud = .box
        case 2:
            cloud = .iCloud
        case 3:
            cloud = .mailRuCloud
        case 4:
            cloud = .gDrive
        default:
            cloud = .dropBox
        }
        
        return cloud
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cloudPickerView.dataSource = self
        cloudPickerView.delegate = self
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}

extension LoadSetupView: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
