//
//  RootViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 6/3/23.
//

import UIKit

final class MainScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "segueGamesToRead",
            let destination = segue.destination as? TableGamesViewController {
             destination.operation = TableGamesViewController.Operation.read
         }
         else if segue.identifier == "segueGamesToUpdate",
            let destination = segue.destination as? TableGamesViewController {
             destination.operation = TableGamesViewController.Operation.update
         }
     }
}
