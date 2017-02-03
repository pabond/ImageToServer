//
//  LoadedImagesViewController.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class LoadedImagesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
