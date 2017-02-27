//
//  LoadedImageView.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/2/17.
//  Copyright (c) 2017 Pavel Bondar. All rights reserved.
//

import UIKit

fileprivate let headerCellHeight: CGFloat = 56.0

class SessionListView: UIView {
    @IBOutlet weak var tableView: UITableView?
    
    //MARK: -
    //MARK: View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = headerCellHeight
    }
}
