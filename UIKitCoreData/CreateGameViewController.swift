//
//  CreateGameViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import UIKit

final class CreateGameViewController: UIViewController, UITextFieldDelegate, ReusablePickerViewDelegate {

    @IBOutlet weak var titleGame: UITextField!
    @IBOutlet weak var designer: UITextField!
    @IBOutlet weak var releaseYear: UITextField!
    @IBOutlet weak var ageTarget: UITextField!
    @IBOutlet weak var complexity: UITextField!
    
    var selectedAgeTarget: Game.TargetAge?
    var selectedComplexity: Game.Complexity?
    
    let opInvoker = CRUDGameOPInvoker()
    let cRUDGameOp = CRUDGameOp()
    let ctx = StorageProvider.shared.persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ageTarget.delegate = self
        complexity.delegate = self
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

    @IBAction func addGame(_ sender: Any) {
        do {
            let commandToRun = CRUDGameCreateInCoreDataCommand(cRUDGameCreate: cRUDGameOp, designer: designer.text, complexity: selectedComplexity, targetAge: selectedAgeTarget, title: titleGame.text ?? "", yearReleased: releaseYear.text, ctx:ctx)
            opInvoker.setCommand(command: commandToRun)
            try opInvoker.run()
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
        }
        catch (ErrorModelLogic.Game.noTitle){
            present(UIAlertController.showAlertOneButtonWithAction(title: "Error creating game",
                                                                   message: "You must enter the title of the game, it is a mandatory field.",
                                                                   descriptionAction: "Enter title",
                                                                   action: {[weak self] action in self?.titleGame.becomeFirstResponder()}
                                                                  ),
                    animated: true,
                    completion: nil)
        }
        catch (ErrorModelLogic.Game.yearFieldIsNotANumber){
            let alertController = UIAlertController(title: "Error creating game", message: "Field \"Release year\" must be a number", preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Edit field", style: .default) { [weak self] action in
                self?.releaseYear.becomeFirstResponder()
            }
            let deleteAction = UIAlertAction(title: "Delete field", style: .destructive) { [weak self] action in
                self?.releaseYear.text = ""
                self?.releaseYear.becomeFirstResponder()
            }
            alertController.addAction(editAction)
            alertController.addAction(deleteAction)
            present(alertController, animated: true, completion: nil)
        }
        catch (ErrorModelLogic.Persistance.gameAlreadyExists){
            let alertController = UIAlertController(title: "Error creating game", message: "This game already exists", preferredStyle: .alert)
            
            let editAction = UIAlertAction(title: "Edit data", style: .default) { [weak self] action in
                self?.titleGame.becomeFirstResponder()
            }
            let abortAction = UIAlertAction(title: "Abort creation", style: .destructive) { [weak self] action in
                if let navigationController = self?.navigationController {
                    navigationController.popViewController(animated: true)
                }
            }
            alertController.addAction(editAction)
            alertController.addAction(abortAction)
            present(alertController, animated: true, completion: nil)
        }
        catch{
            present(UIAlertController.showAlertOkNothing(title: "Error creating game", message: "Unexpected error while creating the game, please try later."), animated: true, completion: nil)
            if let navigationController = self.navigationController {
                navigationController.popViewController(animated: true)
            }
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
