//
//  Session.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/13/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class Session: ArrayModel {
    
    var completedCount = 0
    var ID: String
    var cloudType: CloudType
    
    init(_ name: String, _ cloudType: CloudType) {
        self.ID = name
        self.cloudType = cloudType
    }
}
