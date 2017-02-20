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

public class DBSession: NSManagedObject {
    let observableProgress = PublishSubject<Double>()
    
    var mediaModelsList: DBMediaModels?
    var completedCount: Int {
        guard let models = (mediaModelsList?.models) as? [DBMediaModel] else { return 0 }
        
        return (models.filter { $0.progress == 1 }).count
    }
    
    var progress: Double {
        var progress: Double = 0
        guard let operations = mediaModelsList?.models as? [DBMediaModel] else { return 0 }
        operations.forEach { progress += $0.progress }
        
        return progress/Double(operations.count)
    }
    
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        
        mediaModelsList = DBMediaModels(with: self, keyPath: mediaModelsKeyPath)
    }
    
    class func session(_ name: String, _ cloudType: CloudType) -> DBSession? {
        let session = DBSession.mr_createEntity()
        session?.id = name
        session?.cloudType = cloudType.rawValue
        session?.mediaModelsList = DBMediaModels(with: session, keyPath: mediaModelsKeyPath)
        session?.identifier = 1
        
        return session
    }
    
    func progressChange(_ progress: Double, forItem index: Int) {
        guard let mediaModel = mediaModelsList?[index] as? DBMediaModel else { return }
        mediaModel.progress = progress
        
        observableProgress.onNext(progress)
    }
    
    func shouldReload() -> Bool {
        guard let count = mediaModels?.count else { return false }
        
        return (completedCount - count) == 0
    }
}
