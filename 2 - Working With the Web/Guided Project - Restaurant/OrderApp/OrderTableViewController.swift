//
//  OrderTableViewController.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/7/22.
//

import UIKit

class OrderTableViewController: UITableViewController {
    
    var minutesToPrepareOrder = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        NotificationCenter.default.addObserver(tableView!, selector: #selector(UITableView.reloadData), name: MenuController.orderUpdateNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MenuController.shared.updateUserActivity(with: .order)
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MenuController.shared.order.menuItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Order", for: indexPath)
        
        // Configure the cell...
        configure(cell, forItemAt: indexPath)
        
        return cell
    }
    // configures cell by taking in menuitems
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
                   IndexPath) {
        guard let cell = cell as? MenuItemCell else { return }
        
        let menuItem =
        MenuController.shared.order.menuItems[indexPath.row]
        
        cell.itemName = menuItem.name
        cell.price = menuItem.price
        cell.image = nil
            } 
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            MenuController.shared.order.menuItems.remove(at: indexPath.row)
        }
    }
    
    @IBAction func submitTapped(_ sender: Any) {
        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0) {
            (result, MenuItem) -> Double in return result + MenuItem.price }
        
        let formateedTotal = orderTotal.formatted(.currency(code: "usd"))
        
        let alertController = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formateedTotal)", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Submit", style: .default, handler: { _ in
            self.uploadOrder()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
        
        }
    
    func uploadOrder() {
        let menuIds = MenuController.shared.order.menuItems.map { $0.id }
        Task.init {
            do {
                let minutesToPrepare = try await MenuController.shared.submitOrder(forMenuIDs: menuIds)
                minutesToPrepareOrder = minutesToPrepare
                performSegue(withIdentifier: "confirmOrder", sender: nil)
            } catch {
                displayError(error, title: "Order Submission Failed")
            }
        }
    }
    
    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else {return}
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default,handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
        if segue.identifier == "dismissConfirmation" {
            MenuController.shared.order.menuItems.removeAll()
        }
    }
    
    // this will pass coder and mins left to prepare order
    @IBSegueAction func confirmOrder(_ coder: NSCoder) -> UIViewController? {
        return OrderConfirmationViewController(coder: coder, minutesLeftToPrepare: minutesToPrepareOrder)
    }
    
    
}
