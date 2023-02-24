//
//  DoneUIToolBar.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import UIKit

final class DoneAtTrailingUIToolBar: UIToolbar{
    
    let componentBeenEdited: UIControl
    
    init (componentBeenEdited: UIControl){
        self.componentBeenEdited = componentBeenEdited
        super.init(frame: .zero)
        
        self.barStyle = .default
        self.isTranslucent = true
        self.tintColor = .gray
        self.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButton))
        self.setItems([spacer, done], animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doneButton() {
        componentBeenEdited.resignFirstResponder()
    }
}
