//
//  ButtonFormat.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/5/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import Foundation
import UIKit

class ButtonFormat: UIButton {

    var defaultColor = UIColor.clear {
        didSet {
            if isHighlighted {
                backgroundColor = defaultColor
            }
        }
    }
    
    var highlight = UIColor.white {
        didSet {
            if isHighlighted {
                backgroundColor = highlight
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = highlight
            } else {
                backgroundColor = defaultColor
            }
        }
    }
    
    func setup() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3.0
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    
}
