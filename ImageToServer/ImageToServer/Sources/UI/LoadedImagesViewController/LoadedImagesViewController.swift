//
//  LoadedImagesViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

enum CloudType {
    case dropBox, gDrive, box, mailRuCloud, iCloud
}

class LoadedImagesViewController: UIViewController {
    var loadImageView: LoadedImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageView = viewGetter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ImagePeackViewController else { return }
        vc.startSending = sendImages
    }
    
    func sendImages(to cloudType: CloudType, with images: ArrayModel?) {
        if cloudType == .dropBox {
            images.map {
                let loadContext = FilesToCloudContext(objects: $0)
                loadContext.execute()
            }
        }
    }
}

extension LoadedImagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueCellWithClass(SentImagesCell.self, path: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
