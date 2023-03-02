//
//  UpdateGameViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 2/3/23.
//

import UIKit

final class UpdateGameViewController: UIViewController {

    var gameInScreen: Game?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var designer: UITextField!
    @IBOutlet weak var releaseYear: UITextField!
    @IBOutlet weak var ageTarget: UITextField!
    @IBOutlet weak var complexity: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.text = gameInScreen?.title ?? ""
        designer.text = gameInScreen?.designer ?? ""
        complexity.text = gameInScreen?.complexity?.toEng() ?? ""
        ageTarget.text = gameInScreen?.targetAge?.toEng() ?? ""
        releaseYear.text = gameInScreen?.yearReleased == nil ? "" : String(gameInScreen!.yearReleased!)
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
