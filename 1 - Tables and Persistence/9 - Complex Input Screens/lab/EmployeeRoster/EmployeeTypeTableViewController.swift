//
//  EmployeeTypeTableViewController.swift
//  EmployeeRoster
//
//  Created by Tyler Sun on 10/31/22.
//

import UIKit

protocol EmployeeTypeTableViewControllerDelegate {
    func employeeTypeTableViewController(controller: EmployeeTypeTableViewController, didselect employeeType: EmployeeType)
}

class EmployeeTypeTableViewController: UITableViewController {

    
    var employeeType: EmployeeType?
    var delegate: EmployeeTypeTableViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
// MARK: go to page 252 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EmployeeType.allCases.count
        
    }
//
//
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeTypes", for: indexPath)
        

        let type = EmployeeType.allCases[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = type.description
        cell.contentConfiguration = content
        
        if employeeType == type {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employeeType = EmployeeType.allCases[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
        if let employeeType = employeeType {
            delegate?.employeeTypeTableViewController(controller: self, didselect: employeeType)
        }
        
    }


}
