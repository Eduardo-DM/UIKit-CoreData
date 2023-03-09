//
//  UpdateGameViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 2/3/23.
//

import UIKit

final class UpdateGameViewController: UIViewController, UITextFieldDelegate, ReusablePickerViewDelegate  {

    var initialValuesOfGame: Game?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var designer: UITextField!
    @IBOutlet weak var releaseYear: UITextField!
    @IBOutlet weak var ageTarget: UITextField!
    @IBOutlet weak var complexity: UITextField!
    
    var selectedAgeTarget: Game.TargetAge?
    var selectedComplexity: Game.Complexity?
    
    let opInvoker = CRUDGameOPInvoker()
    let ctx = StorageProvider.shared.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = initialValuesOfGame?.title ?? ""
        designer.text = initialValuesOfGame?.designer ?? ""
        releaseYear.text = initialValuesOfGame?.yearReleased == nil ? "" : String(initialValuesOfGame!.yearReleased!)
        ageTarget.delegate = self
        complexity.delegate = self
        ageTarget.text = initialValuesOfGame?.targetAge?.toEng()
        complexity.text = initialValuesOfGame?.complexity?.toEng()
        
        selectedAgeTarget = initialValuesOfGame?.targetAge
        selectedComplexity = initialValuesOfGame?.complexity
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let items: [String]
        let initialValue: String
        if textField.tag == 1{
            items = Game.TargetAge.allCases
                .map{
                    switch $0{
                    case .babies:
                        return "Babies"
                    case .children:
                        return "Children"
                    case .teenagers:
                        return "Teenagers"
                    case .adults:
                        return "Adults"
                    }
                }
            initialValue = ageTarget.text ?? ""
        }
        else {// the other case  is tag equals 2
            items = Game.Complexity.allCases
                .map{
                    switch $0{
                    case .casual: return "Casual"
                    case .easy: return "Easy"
                    case .medium: return "Medium"
                    case .hard: return "Hard"
                    }
                }
            initialValue = complexity.text ?? ""
        }
        let picker = CustomUIPickerView(items: items, initialValue: initialValue, tag: textField.tag)
        picker.delegateReusable = self
        textField.inputView = picker
        textField.inputAccessoryView = DoneAtTrailingUIToolBar(componentBeenEdited: textField)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
    
    func didSelectRow(pickerView: UIPickerView, selectedString string: String) {
        let selectedPos = pickerView.selectedRow(inComponent: 0)
        if pickerView.tag == 1 {
            ageTarget.text = string
            selectedAgeTarget = Game.TargetAge(rawValue: selectedPos)
        }
        if pickerView.tag == 2 {
            complexity.text = string
            selectedComplexity = Game.Complexity(rawValue: selectedPos)
        }
    }
    
    @IBAction func updateGame(_ sender: Any) {
        do {
            let commandToRun = CRUDGameUpdateInCoreDataCommand(originalTitle: initialValuesOfGame?.title ?? "",
                                                               designer: designer.text,
                                                               complexity: selectedComplexity,
                                                               targetAge: selectedAgeTarget,
                                                               actualTitle: titleTextField.text ?? "",
                                                               yearReleased: releaseYear.text,
                                                               ctx: ctx)
            opInvoker.setCommand(command: commandToRun)
            try opInvoker.run()
            dismiss(animated: true, completion: nil)
        }
        catch {
            dismiss(animated: true, completion: nil)
            present(UIAlertController.showAlertOkNothing(title: "Error updating the game",
                                                         message: "Enter title"),
                    animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
