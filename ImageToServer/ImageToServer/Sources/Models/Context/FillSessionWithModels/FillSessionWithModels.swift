//
//  FillSessionWithModels.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/20/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

let kApplicationFolderName = "ImageToServer"

class FillSessionWithModels: Context {
    var mediaModels: ArrayModel?
    var session: DBSession!
    
    class func fillSession(_ session: DBSession, with models: ArrayModel?) -> FillSessionWithModels {
        let context = FillSessionWithModels()
        
        context.session = session
        context.mediaModels = models
        
        return context	
    }
    
    override func execute() {
        guard let models = mediaModels?.models as? [MediaModel] else { return }
        var dbMediaModel: DBMediaModel?
        for model in models {
            guard let image = model.image, let data = UIImageJPEGRepresentation(image, 600)  else { return }
            guard let fileName = model.assetID else { break }
            let filePath = path(fileName: fileName)
            saveDataToFileSystem(data: data, path: filePath)
            dbMediaModel = DBMediaModel.MediaModel(assetID: model.assetID, imageURL: filePath)
            dbMediaModel.map { session.mediaModelsList?.addModel($0) }
        }
    }
    
    func saveDataToFileSystem(data: Data, path: String) {
        if !fileExistInFileSystem(path: path) {
            FileManager.default.createFile(atPath: path as String, contents: data, attributes: nil)
        }
    }
    
    func fileExistInFileSystem(path: String) -> Bool {
        return FileManager.default.fileExists(atPath: path)
    }
    
    func path (fileName: String) -> String {
        return (FileManager.applicationDataPath(withFolderName: kApplicationFolderName)).appending("/\(allowedFileName(fileName: fileName)).jpg")
    }
    
    func allowedFileName(fileName: String) -> String {
        return fileName.addingPercentEncoding(withAllowedCharacters: CharacterSet.alphanumerics)!
    }
}
