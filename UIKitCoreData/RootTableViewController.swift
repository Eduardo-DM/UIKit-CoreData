//
//  RootTableViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 15/2/23.
//

import UIKit

final class RootTableViewController: UITableViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImage(named: "PolyBackground")
        let imageView = UIImageView(image: backgroundImage)

        imageView.contentMode = .scaleAspectFill
        imageView.frame = tableView.frame

        tableView.backgroundView = imageView
        
        tableView.isScrollEnabled = false
        
        let topBackgroundColor = UIColor.systemIndigo.withAlphaComponent(0.6)
        
        let topSafeAreaInset: CGFloat
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            topSafeAreaInset = windowScene.windows.first?.safeAreaInsets.top ?? 0
        }
        else{
            topSafeAreaInset = 0
        }
        let coverSafeArea = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: topSafeAreaInset))
        coverSafeArea.backgroundColor = topBackgroundColor
        tableView.backgroundView?.addSubview(coverSafeArea)
        
        let topSafeAreaInsetsNavigationBar = navigationController?.navigationBar.safeAreaInsets.top ?? 0
        let navigationBarHeight = navigationController?.navigationBar.frame.size.height ?? 0
        let coverNavigationBar = UIView(frame: CGRect(x: 0, y: topSafeAreaInset, width: view.bounds.width, height: navigationBarHeight - topSafeAreaInsetsNavigationBar))
        coverNavigationBar.backgroundColor = topBackgroundColor
        tableView.backgroundView?.addSubview(coverNavigationBar)
        
        let endNavigationBar = topSafeAreaInset - topSafeAreaInsetsNavigationBar + navigationBarHeight
        
        let aaa = tableView.rectForHeader(inSection: 0)
        let startSection = tableView.rectForHeader(inSection: 0).origin.y
        let coverBandOverSection = UIView(frame: CGRect(x: 0, y: endNavigationBar, width: view.bounds.width, height: startSection))
        coverBandOverSection.backgroundColor = topBackgroundColor
        tableView.backgroundView?.addSubview(coverBandOverSection)

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
