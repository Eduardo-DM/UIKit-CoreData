//
//  TableGamesViewController.swift
//  UIKitCoreData
//
//  Created by Eduardo Developer on 24/2/23.
//

import UIKit
import CoreData

final class TableGamesViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    enum Operation{
        case read, update
    }
    
    var fetchedResultsController: NSFetchedResultsController<Games>!
    
    var operation: Operation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch operation{
        case .read:
            self.navigationItem.title = "Read operation"
        case .update:
            self.navigationItem.title  = "Update operation"
        case .none:
            self.navigationItem.title = "CRUD"
        }
        
        // Set up the fetch request
        let fetchRequest: NSFetchRequest<Games> = Games.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]//CoreDataStack.shared.managedObjectContext
        
        // Set up the fetched results controller
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: StorageProvider.shared.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error fetching games: \(error)")
        }
        
     
        let backgroundImage = UIImage(named: "PolyBackground")
        let imageView = UIImageView(image: backgroundImage)

        imageView.contentMode = .scaleAspectFill
        imageView.frame = tableView.frame

        tableView.backgroundView = imageView
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "zeldaGame", for: indexPath)

        let gameFromCoreData = fetchedResultsController.object(at: indexPath)
        
        var contentOfZeldaGame = UIListContentConfiguration.cell()
        contentOfZeldaGame.text = "\(gameFromCoreData.title ?? "No title")"
        contentOfZeldaGame.secondaryText = "\(gameFromCoreData.designer ?? "Unassigned designer")"
        cell.contentConfiguration = contentOfZeldaGame
        
        switch operation{
        case .read:
            cell.accessoryType = .detailButton
            self.navigationItem.title = "Read operation"
        case .update:
            cell.accessoryType = .disclosureIndicator
        case .none:
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch self.operation{
        case .read:
            performSegue(withIdentifier: "segueReadGameDetails", sender: indexPath)
        case .update:
            performSegue(withIdentifier: "segueUpdateGameDetails", sender: indexPath)
        case .none:
            return
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueReadGameDetails",
            let destination = segue.destination as? ReadGameViewController,
            let indexPath = sender as? IndexPath {
            let gameFromCoreData = fetchedResultsController.object(at: indexPath)
            do {
                destination.gameInScreen = try Game(gameCoreData: gameFromCoreData)
            }
            catch{
                present(UIAlertController.showAlertOkNothing(title: "Unexpected error", message: "It was imposible recover information about the game, please try later."), animated: true, completion: nil)
            }
        }
        else if segue.identifier == "segueUpdateGameDetails",
            let destination = segue.destination as? UpdateGameViewController,
            let indexPath = sender as? IndexPath {
            let gameFromCoreData = fetchedResultsController.object(at: indexPath)
            do {
                destination.initialValuesOfGame = try Game(gameCoreData: gameFromCoreData)
            }
            catch{
                present(UIAlertController.showAlertOkNothing(title: "Unexpected error", message: "It was imposible recover information about the game, please try later."), animated: true, completion: nil)
            }
        }
    }
    

}
