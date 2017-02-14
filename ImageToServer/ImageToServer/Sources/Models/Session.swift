//
//  Session.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/13/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit
import RxSwift

class Session: ArrayModel {
    let observableProgress = PublishSubject<Double>()
    
    var ID: String
    var cloudType: CloudType
    var completedCount: Int { return (models.filter { $0.progress == 1 }).count }
    
    init(_ name: String, _ cloudType: CloudType) {
        self.ID = name
        self.cloudType = cloudType
    }
    
    func progressChange(_ progress: Double, forItem index: Int) {
        guard let mediaModel = self[index] as? MediaModel else { return }
        mediaModel.progress = progress
        var progress: Double = 0
        guard let operations = models as? Array<MediaModel> else { return }
        operations.forEach { progress += $0.progress }
        observableProgress.onNext(progress/Double(count))
    }
}
