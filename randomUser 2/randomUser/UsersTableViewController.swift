//
//  UsersTableViewController.swift
//  randomUser
//
//  Created by Tyler Sun on 2/24/23.
//

import UIKit

class UsersTableViewController: UITableViewController {
        
    var user: [User] = [User(name: "jon"), User(name: "sally"), User(name: "zach")]

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? RandomUserViewController {
            destination.user = self.user
        }
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Users", for: indexPath)
        
        let user = user[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = user.name
        cell.contentConfiguration = content
        return cell
    }
    
    @IBSegueAction func addUser(_ coder: NSCoder) -> AddUserViewController? {
        return AddUserViewController(coder: coder, newUser: nil)
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard let vc = segue.source as? AddUserViewController,
              let newUser = vc.newUser else { return
            print("destination does not work")
        }
      if let selectedIndexPath = tableView.indexPathForSelectedRow {
          user[selectedIndexPath.row] = newUser
      } else {
          user.append(newUser)
          print("added user")
      }
    }
}
