//
//  SentImagesCell.swift
//  ImageToServer
//
//  Created by Guest User on 2/3/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class SentImagesCell: TableViewCell {
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionProgress: UIProgressView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var operationsCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func fillWith(_ object: AnyObject?) {
        guard let session = object as? Session else { return }
        
        cloudImageView.image = UIImage(named: session.cloudType.rawValue)
        sessionProgress.setProgress(0, animated: false)
        sessionNameLabel.text = session.ID
        operationsCountLabel.text = String(session.count)
        completedLabel.text = String(session.completedCount)
    }
    
    func setProgress(_ progress: Double, for item: Int) {
        sessionProgress.setProgress(Float(progress), animated: true)
    }
}
