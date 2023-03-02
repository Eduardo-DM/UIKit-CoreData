//
//  RootTableViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import UIKit

class RootTableViewController: UITableViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "PolyBackground")
        let imageView = UIImageView(image: backgroundImage)

        imageView.contentMode = .scaleAspectFill
        imageView.frame = tableView.frame

        tableView.backgroundView = imageView
        
        tableView.isScrollEnabled = false
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    
    // MARK: - Interface
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.white.withAlphaComponent(0.7)
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .white.withAlphaComponent(0.8)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("hola")
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
