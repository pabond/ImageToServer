//
//  SentImagesCell.swift
//  ImageToServer
//
//  Created by Guest User on 2/3/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

class SentImagesCell: TableViewCell {
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionProgress: UIProgressView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var operationsCountLabel: UILabel!
    
    let disposeBag = DisposeBag()

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func fillWith(_ object: AnyObject?) {
        guard let session = object as? Session else { return }
        subcribeOnProgress(session)
        
        cloudImageView.image = UIImage(named: session.cloudType.rawValue)
        sessionNameLabel.text = session.ID
        operationsCountLabel.text = String(session.count)
        completedLabel.text = String(session.completedCount)
    }
    
    func setProgress(_ progress: Double, for item: Int) {
        sessionProgress.setProgress(Float(progress), animated: true)
    }
    
    func subcribeOnProgress(_ session: Session) {
        session.observableProgress.subscribe({ [weak self] (progress) in
            guard let progress = progress.element else { return }
            DispatchQueue.main.async { [weak self] () -> Void in
                self?.sessionProgress.setProgress(Float(progress), animated: true)
                self?.completedLabel.text = String(session.completedCount)
            }
        }).addDisposableTo(disposeBag)
    }
}
