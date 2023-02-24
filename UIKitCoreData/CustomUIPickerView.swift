//
//  ReusablePickerView.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import UIKit

protocol ReusablePickerViewDelegate {
    func didSelectRow(pickerView:UIPickerView, selectedString string: String)
}

final class CustomUIPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let items: [String]
    
    init(items: [String], initialValue: String, tag: Int = 0) {
        self.items = items
        super.init(frame: .zero)
        super.tag = tag
        delegate = self
        dataSource = self
        if let index = items.firstIndex(where: { $0 == initialValue }) {
            selectRow(index, inComponent: 0, animated: false)
        }
    }
    
    required init?(coder: NSCoder) {
        self.items = []
        super.init(coder: coder)
    }
    
    var delegateReusable: ReusablePickerViewDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        items[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegateReusable?.didSelectRow(pickerView: pickerView, selectedString: items[row])
    }
}
