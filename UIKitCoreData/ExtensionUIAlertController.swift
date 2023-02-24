//
//  ExtensionUIAlertController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 23/2/23.
//

import UIKit

extension UIAlertController {
    static func showAlertOkNothing(title:String, message:String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    static func showAlertOneButtonWithAction(title:String, message:String, descriptionAction: String, action: @escaping (UIAlertAction)-> Void) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: descriptionAction, style: .default, handler: action))
        return alert
    }
}
