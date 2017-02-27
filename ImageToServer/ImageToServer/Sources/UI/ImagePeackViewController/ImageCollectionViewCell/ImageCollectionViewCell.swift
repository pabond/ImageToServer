//
//  ImageCollectionViewCell.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/3/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: -
    //MARK: Public implementations
    
    func fillWith(_ object: AnyObject?) {
        guard let image = object as? UIImage else { return }
        imageView.image = image
    }
}
