//
//  SentImagesCell.swift
//  ImageToServer
//
//  Created by Guest User on 2/3/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

class SentImagesCell: UITableViewCell {
    @IBOutlet weak var cloudImageView: UIImageView!
    @IBOutlet weak var sessionNameLabel: UILabel!
    @IBOutlet weak var sessionProgress: UIProgressView!
    @IBOutlet weak var completedLabel: UILabel!
    @IBOutlet weak var operationsCountLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!

    let disposeBag = DisposeBag()
    
    var object: AnyObject?
    var session: DBSession?
    
    //MARK: -
    //MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onStateImage(_:)))
        stateImageView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: -
    //MARK: Public implementations

    func fillWith(_ object: AnyObject?) {
        guard let session = object as? DBSession else { return }
        self.session = session
        subcribeOnProgress(session)
        subscribeOnState(session)
        
        session.state.map { stateImageView.image = UIImage(named: $0) }
        
        cloudImageView.image = UIImage(named: (session.cloudType) ?? "")
        sessionNameLabel.text = session.id
        operationsCountLabel.text = String((session.mediaModels?.count) ?? 0)
        completedLabel.text = String(session.completedCount)
        sessionProgress.setProgress(Float(session.progress), animated: false)
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    func onStateImage(_ sender: Any) {
        switch session?.state {
        case SessionState.sessionReadyForLoad.rawValue?:
            session?.load()
            break
        case SessionState.sessionFailLoading.rawValue?:
            session?.load()
            break
        case SessionState.sessionWillLoad.rawValue?:
            session?.shouldStopLoading = true
            break
        default: return
        }
    }
    
    //MARK: -
    //MARK: Private implementations
    
     private func setProgress(_ progress: Double, for item: Int) {
        sessionProgress.setProgress(Float(progress), animated: true)
    }
    
    private func subcribeOnProgress(_ session: DBSession) {
        session.observableProgress.observeOn(MainScheduler.asyncInstance).subscribe({ [weak self] (progress) in
            guard let progress = progress.element else { return }
            self?.sessionProgress.setProgress(Float(progress), animated: true)
            self?.completedLabel.text = String(session.completedCount)
            
            if progress == 1 {
                session.state = SessionState.sessionDidLoad.rawValue
                self?.setImageWithState(state: .sessionDidLoad)
            }
        }).addDisposableTo(disposeBag)
    }
    
    private func subscribeOnState(_ session: DBSession) {
        _ = session.observableState.observeOn(MainScheduler.instance).subscribe({ [weak self] (state) in
            self?.setImageWithState(state: state.element)
            self?.stateImageView.image = state.element?.image
        }).addDisposableTo(disposeBag)
    }
    
    private func setImageWithState(state: SessionState?) {
        stateImageView.image = state?.image
    }
}
