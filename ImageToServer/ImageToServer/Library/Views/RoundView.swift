//
//  RoundView.swift
//  ImageToServer
//
//  Created by Pavel Bondar on 2/6/17.
//  Copyright © 2017 Pavel Bondar. All rights reserved.
//

import UIKit

class RoundView: RoundedView {
    override var cornerRadius: CGFloat {
        return frame.width / 2
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView(cornerRadius: cornerRadius)
    }
}
