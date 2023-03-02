//
//  CustomUIVisualEffect.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 2/3/23.
//

import UIKit

@IBDesignable
class CustomUIVisualEffectView: UIVisualEffectView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.cornerCurve = .continuous
            layer.masksToBounds = true
        }
    }
}
