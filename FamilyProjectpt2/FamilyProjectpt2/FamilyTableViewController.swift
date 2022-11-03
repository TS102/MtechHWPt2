//
//  FamilyTableViewController.swift
//  FamilyProjectpt2
//
//  Created by Tyler Sun on 11/1/22.
//

import UIKit

class FamilyTableViewController: UITableViewController {


    var familyMember: [Family] = [
        Family(name: "Mom", familyInfo: [FamilyInfo(name: "Mom", description: "My Mom likes cats and cars.", age: "41")]),
        Family(name: "Dad", familyInfo: [FamilyInfo(name: "Dad", description: "He looks like a UFC Fighter for some reason", age: "44")]),
        Family(name: "brother", familyInfo: [FamilyInfo(name: "Brother", description: "He is a menace to society", age: "14")]),
        Family(name: "Me", familyInfo: [FamilyInfo(name: "Me", description: "I am taking a mobile dev class", age: "20")])
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return familyMember.count
    }

     
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Family Cell", for: indexPath)
      
        let family = familyMember[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = family.name
        cell.contentConfiguration = content
        
        // Configure the cell...

        return cell
    }
    
    
// this segue will pull the info for and putting it into the view controller
    @IBSegueAction func familyDetailSegue(_ coder: NSCoder) -> FamilyInfoViewController? {
        
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else {return FamilyInfoViewController(coder: coder, familyInfo: nil)}
        
        return FamilyInfoViewController(coder: coder, familyInfo: familyMember[selectedIndexPath.row].familyInfo[0])
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
