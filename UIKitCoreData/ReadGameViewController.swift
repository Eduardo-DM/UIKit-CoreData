//
//  ReadGameViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 24/2/23.
//

import UIKit

class ReadGameViewController: UIViewController {
    
    var gameInScreen: Game?

    @IBOutlet weak var titleGame: UILabel!
    @IBOutlet weak var designer: UILabel!
    @IBOutlet weak var complexity: UILabel!
    @IBOutlet weak var targetAge: UILabel!
    @IBOutlet weak var releaseYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        titleGame.text = gameInScreen?.title ?? ""
        designer.text = gameInScreen?.designer ?? ""
        complexity.text = gameInScreen?.complexity?.toEng() ?? ""
        targetAge.text = gameInScreen?.targetAge?.toEng() ?? ""
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
