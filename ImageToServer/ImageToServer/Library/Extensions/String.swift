//
//  String.swift
//  Heart
//
//  Created by Bondar Pavel on 1/12/17.
//  Copyright © 2017 Martynets Ruslan. All rights reserved.
//

import Foundation

extension String {
    
    func containsStrict(_ find: String) -> Bool {
        return range(of: find) != nil
    }
    
    func contains(_ find: String) -> Bool{
        return self.lowercased().range(of: find.lowercased()) != nil
    }
}
