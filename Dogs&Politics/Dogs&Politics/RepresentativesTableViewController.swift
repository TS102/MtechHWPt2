//
//  RepresentativesTableViewController.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/2/22.
//

import UIKit

class RepresentativesTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var repsItemController = RepItemsController()
    var items = [RepsItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func fetchMatchingItems() {
        self.items = []
        self.tableView.reloadData()
        let searchTerm = searchBar.text ?? ""
        
        if !searchTerm.isEmpty {
            let query = [
                "lang": "en_us",
                "zip": searchTerm,
                "output": "json"
            ]
            
            Task {
                do {
                    self.items = try await repsItemController.fetchItems(matching: query)
                    tableView.reloadData()
                    print("working")
                } catch {
                    print(error)
                }
            }
        }
    }
    
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "representatives", for: indexPath) as! RepresentativesableViewCell
        cell.repsNameLabel.text = items[indexPath.row].name
        cell.partyLabel.text = items[indexPath.row].district
        cell.linkLabel.text = items[indexPath.row].link
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    enum RepItemError: Error, LocalizedError {
        case error
    }
}
extension RepresentativesTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        fetchMatchingItems()
        searchBar.resignFirstResponder()
    }
}
