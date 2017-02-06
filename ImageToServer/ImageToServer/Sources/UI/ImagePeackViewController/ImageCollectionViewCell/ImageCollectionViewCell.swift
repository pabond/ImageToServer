//
//  ImageCollectionViewCell.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/3/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var selectedView: RoundView!
    @IBOutlet weak var imageView: UIImageView!

    var object: UIImage? {
        didSet {
            fillWith(self.object)
        }
    }
    
    func fillWith(_ object: AnyObject?) {
        guard let image = object as? UIImage else { return }
        imageView.image = image
    }
}
