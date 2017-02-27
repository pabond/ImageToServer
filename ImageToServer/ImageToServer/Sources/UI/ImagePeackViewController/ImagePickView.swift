//
//  ImagePickView.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class ImagePickView: UIView {
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: -
    //MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.allowsMultipleSelection = true
    }
}
