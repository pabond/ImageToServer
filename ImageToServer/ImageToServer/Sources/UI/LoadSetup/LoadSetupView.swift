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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
        }
    }
}
