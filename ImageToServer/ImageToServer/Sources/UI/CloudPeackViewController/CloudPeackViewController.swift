//
//  CloudPeackViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class CloudPeackViewController: TrancitionViewController {
    var loadImages: ((_: CloudType) -> ())?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupTransition()
    }
    
    func setupTransition() {
        slideInTransitioningDelegate.direction = .bottom
        slideInTransitioningDelegate.size = .twoThirds
        self.transitioningDelegate = slideInTransitioningDelegate
        self.modalPresentationStyle = .custom
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCancel(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func onICloud(_ sender: Any) {
        informOfType(.iCloud)
    }
    
    @IBAction func onGoogleDrive(_ sender: Any) {
        informOfType(.gDrive)
    }
    
    @IBAction func onDropbox(_ sender: Any) {
        informOfType(.dropBox)
    }
    
    @IBAction func onBox(_ sender: Any) {
        informOfType(.box)
    }
    
    @IBAction func onCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func informOfType(_ type: CloudType) {
        dismiss(animated: true, completion: { [weak self] in
            self?.loadImages.map { $0(type) }
        })
    }
}
