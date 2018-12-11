//
//  DesignFeatures.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/5/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addFadeBackground(top: UIColor, bottom: UIColor) {
        let fade = CAGradientLayer()
        fade.frame = self.bounds
        fade.colors = [
            top.cgColor,
            bottom.cgColor
        ]
        fade.locations = [0.0, 1.0]
        fade.startPoint = CGPoint(x: 0, y: 0)
        fade.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(fade, at: 0)
    }
}
