//
//  RoundedView.swift
//  RecipesList
//
//  Created by Bondar Pavel on 12/8/16.
//  Copyright © 2016 goit.taras.spasibov. All rights reserved.
//

import UIKit

class RoundedView: UIView {
    var cornerRadius: CGFloat { return 10 }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.roundedView(cornerRadius: cornerRadius)
        clipsToBounds = true
    }
}

extension UIView {
    func roundedView(cornerRadius: CGFloat) -> Void {
        self.layer.cornerRadius = cornerRadius
    }
}
