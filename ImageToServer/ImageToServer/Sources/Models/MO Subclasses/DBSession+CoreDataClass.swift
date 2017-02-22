//
//  DBSession+CoreDataClass.swift
//  
//
//  Created by Pavel Bondar on 2/15/17.
//
//

import Foundation
import CoreData
import RxSwift

fileprivate let mediaModelsKeyPath = "mediaModels"

enum SessionState: String {
    case sessionFailLoading, sessionWillLoad, sessionDidLoad, sessionReadyForLoad
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

public class DBSession: NSManagedObject {
    let observableProgress = PublishSubject<Double>()
    let observableState = ReplaySubject<SessionState>.create(bufferSize: 2)

    var loadContext: FilesToCloudContext?
    var mediaModelsList: DBMediaModels?
    var shouldStopLoading = false {
        didSet {
            if shouldStopLoading {
                loadContext?.cancelLoading()
            }
        }
    }
    var completedCount: Int {
        guard let models = (mediaModelsList?.models) as? [DBMediaModel] else { return 0 }
        
        return (models.filter { $0.progress == 1 }).count
    }
    
    var sessionState: SessionState? {
        didSet {
            state = sessionState?.rawValue
            if sessionState != nil && oldValue != sessionState {
                observableState.onNext(sessionState!)
            }
        }
    }
    
    var progress: Double {
        var progress: Double = 0
        guard let operations = mediaModelsList?.models as? [DBMediaModel] else { return 0 }
        operations.forEach { progress += $0.progress }
        
        return progress/Double(operations.count)
    }
    
    class func session(_ name: String, _ cloudType: CloudType) -> DBSession? {
        let session = DBSession.mr_createEntity()
        session?.id = name
        session?.cloudType = cloudType.rawValue
        session?.mediaModelsList = DBMediaModels(with: session, keyPath: mediaModelsKeyPath)
        session?.identifier = 1
        session?.state = SessionState.sessionReadyForLoad.rawValue
        
        return session
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        mediaModelsList = DBMediaModels(with: self, keyPath: mediaModelsKeyPath)
    }
    
    func progressChange(_ progress: Double, forItem index: Int) {
        guard let mediaModel = mediaModelsList?[index] as? DBMediaModel else { return }
        mediaModel.progress = progress
        
        observableProgress.onNext(self.progress)
    }
    
    func load() {
        let loadContext = FilesToCloudContext.uploadContext(self)
        self.loadContext = loadContext
        loadContext.execute()
    }
    
    func shouldReload() -> Bool {
        guard let count = mediaModels?.count else { return false }
        
        return (completedCount - count) == 0
    }
}
