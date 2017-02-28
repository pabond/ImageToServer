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

class SessionListViewController: UIViewController, RootViewGettable {
    
    typealias RootViewType = SessionListView
    
    let disposeBag = DisposeBag()
    
    var sessions: DBSessions?

    //MARK: -
    //MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView?.tableView?.registerCell(withClass: SentImagesCell.self)
        
        sessions = DBSessions(with: nil, keyPath: sessionsKeyPath)
        
        sessions?.observable.observeOn(MainScheduler.asyncInstance).subscribe({ [weak self] (change) in
            _ = change.map({ $0.apply(to: (self?.rootView?.tableView)!) })
        }).addDisposableTo(disposeBag)
    }
    
    //MARK: -
    //MARK: Interface Handling
    
    @IBAction func onLoadSetup(_ sender: Any) {
        guard let vc = instantiateViewControllerOnMain(withClass: LoadSetupViewController.self) else { return }
        vc.startLoading = startLoading
        navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: -
    //MARK: Private functions
    
    private func startLoading(_ session: DBSession) {
        sessions?.addModel(session)
        session.load()
    }
}

//MARK: -
//MARK: UITableViewDelegate, UITableViewDataSource

extension SessionListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sessions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCellWithClass(SentImagesCell.self, path: indexPath)
        cell.fillWith(sessions?[indexPath.row])

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
