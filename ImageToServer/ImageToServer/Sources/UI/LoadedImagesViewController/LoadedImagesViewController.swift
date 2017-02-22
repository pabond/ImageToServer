//
//  LoadedImagesViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

enum CloudType: String {
    case dropBox, box, mailRuCloud, iCloud, gDrive
}

fileprivate let sessionsKeyPath = "sessions"

class LoadedImagesViewController: UIViewController {
    let disposeBag = DisposeBag()
    var loadImageView: LoadedImageView?
    
    var sessions: DBSessions?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadImageView = viewGetter()
        loadImageView?.tableView.registerCell(withClass: SentImagesCell.self)
        
        sessions = DBSessions(with: nil, keyPath: sessionsKeyPath)
        
        sessions?.observable.observeOn(MainScheduler.asyncInstance).subscribe({ [weak self] (change) in
            _ = change.map({ $0.apply(to: (self?.loadImageView?.tableView)!) })
        }).addDisposableTo(disposeBag)
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
    
    func startLoading(_ session: DBSession) {
        sessions?.addModel(session)
        session.load()
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
        return sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellWithClass(SentImagesCell.self, path: indexPath)
        let session = sessions?[indexPath.row]
        cell.object = session

        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete {
            let session = sessions?.model(at: indexPath.row) as! DBSession
            session.mr_deleteEntity()
        }
    }
}
