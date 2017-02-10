//
//  FilesToCloudContext.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import SwiftyDropbox
import UIKit

class FilesToCloudContext: Context {
    fileprivate var objectsToLoad: ArrayModel?
    fileprivate var sessionID: String?
    
    init(objects: ArrayModel, sessionID: String?) {
        super.init()
        
        objectsToLoad = objects
        self.sessionID = sessionID
    }
    
    override func execute() {
        let client = DropboxClientsManager.authorizedClient
        if client == nil {
            let loginContext = LoginWithDropbox()
            loginContext.execute()
        }
        
        guard let cli = client, let models = objectsToLoad else { return }
        for i in 0..<models.count {
            guard let model = objectsToLoad?[i] as? UIImage else { break }
            guard let data = UIImageJPEGRepresentation(model, 200)  else { return }
            
//            guard let sessionID = sessionID  else { return }
//            let cursor =  Files.UploadSessionCursor(sessionId: sessionID, offset: 0)
//            _ = cli.files.uploadSessionAppendV2(cursor: cursor, input: data)
            
            _ = cli.files.upload(path: "/myPhotos/\(NSDate())\(i).jpeg", input: data)
                .response { response, error in
                    if let response = response {
                        print(response)
                    } else if let error = error {
                        print(error)
                    }
                }
                .progress { progressData in
                    print(progressData)
                }
        }
        
        // in case you want to cancel the request
//        if Bool {
//            request.cancel()
//        }
    }
}

//func uploadLargeFile(srcPath a_sSrcPath:String, dstPath a_sDstPath:String){
//    
//    if let client = DropboxClientsManager.authorizedClient {
//        
//        let inputStrm            = InputStream(fileAtPath: a_sSrcPath)
//        inputStrm!.open()
//        let sendBlockByte        = 1024 * 1024 * 50  //50MB
//        var transferedCnt:UInt64 = 0
//        var buffer               = Array<UInt8>(repeating:0, count:sendBlockByte)
//        var data                 = Data(bytesNoCopy: &buffer, count:sendBlockByte, deallocator: .none)
//        var sessionID            = ""
//        var retryCnt             = 0
//        
//        
//        
//        var appendNextBlock:() -> Void = { () -> Void in }
//        appendNextBlock = { () in
//            
//            let readCnt = inputStrm!.read(&buffer, maxLength: sendBlockByte)
//            if (readCnt > 0) {
//                if (readCnt != sendBlockByte) {
//                    data = Data(bytesNoCopy: &buffer, count:(readCnt >= 0 ? readCnt: 0), deallocator: .none)
//                }
//                
//                var fncCompletion:((Void)?, CallError<(Files.UploadSessionLookupError)>?) -> Void = { (_, _) -> Void in }
//                fncCompletion = { (response, error) in
//                    
//                    response.map { debugPrint($0) }
//                    
//                    if error != nil {
//                        // Lets Rety
//                        retryCnt += 1
//                        if (retryCnt < 4) {
//                            let cursor =  Files.UploadSessionCursor(sessionId: sessionID, offset: transferedCnt)
//                            client.files.uploadSessionAppendV2(cursor: cursor, input: data).response(completionHandler: fncCompletion)
//                        }else{
//                            debugPrint("ERROR")
//                        }
//                    }else{
//                        transferedCnt = transferedCnt + UInt64(readCnt)
//                        retryCnt = 0
//                        appendNextBlock()
//                    }
//                }
//                let cursor =  Files.UploadSessionCursor(sessionId: sessionID, offset: transferedCnt)
//                client.files.uploadSessionAppendV2(cursor: cursor, input: data).response(completionHandler: fncCompletion)
//            }else{
//                
//                //finish
//                if (transferedCnt > 0) {
//                    let sessionCursor = Files.UploadSessionCursor(sessionId: sessionID, offset: transferedCnt)
//                    let commitInfo = Files.CommitInfo(path: a_sDstPath, mode: .overwrite, autorename: false, clientModified: nil, mute: false)
//                    
//                    client.files.uploadSessionFinish(cursor: sessionCursor, commit: commitInfo, input: Data()).response(completionHandler: { (response, error) in
//                        if let _ = response {
//                            debugPrint("FINISH")
//                        }else{
//                            debugPrint("ERROR")
//                        }
//                    })
//                }else{
//                    debugPrint("ERROR")
//                }
//            }
//        }
//        
//        //Data
//        let tmp = Data()
//        client.files.uploadSessionStart(input: tmp).response(completionHandler: {
//            (response, errorType) -> Void in
//            if let (startResult) = response {
//                sessionID = startResult.sessionId
//                appendNextBlock()
//            }else{
//                debugPrint("ERROR")
//            }
//        })
//    }
//}
