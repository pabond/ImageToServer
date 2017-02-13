//
//  Enum + Extensions.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/13/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import Foundation

func enumCount<T: Hashable>(_ t: T.Type) -> Int {
    var i = 1
    while (withUnsafePointer(to: &i) {
        $0.withMemoryRebound(to:t.self, capacity:1) { $0.pointee.hashValue != 0 }
    }) { i += 1 }
    
    return i
}
