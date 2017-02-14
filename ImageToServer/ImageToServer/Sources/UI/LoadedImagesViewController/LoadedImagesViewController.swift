//
//  LoadedImagesViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

enum CloudType: String {
    case dropBox, box, mailRuCloud, iCloud, gDrive
}

class LoadedImagesViewController: UIViewController {
    var loadImageView: LoadedImageView?
    var sessions = Sessions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageView = viewGetter()
        loadImageView?.tableView.registerCell(withClass: SentImagesCell.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ImagePickViewController else { return }
        vc.startSending = pickedImages
    }
    
    func pickedImages(with mediaModels: ArrayModel?) {
        guard let vc = instantiateViewControllerOnMain(withClass: LoadSetupViewController.self) else { return }
        vc.mediaModels = mediaModels
        vc.startLoading = startLoading
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func startLoading(_ session: Session) {
        sessions.addModel(session)
        loadImageView?.tableView.reloadData()
        let loadContext = FilesToCloudContext.uploadContext(session)
        loadContext.execute()
    }
    
    @IBAction func onLoadSetup(_ sender: Any) {
        pickedImages(with: nil)
    }
    
    @IBAction func onPickImages(_ sender: Any) {
        guard let vc = instantiateViewControllerOnMain(withClass: ImagePickViewController.self) else { return }
        vc.startSending = pickedImages
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoadedImagesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellWithClass(SentImagesCell.self, path: indexPath)
        cell.object = sessions[indexPath.row]
        
        return cell
    }
}
