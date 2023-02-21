//
//  SearchTableViewController.swift
//  Life-FormSearch
//
//  Created by Tyler Sun on 1/20/23.
//

import UIKit

protocol SearchTableViewControllerDelegate {
    func sendData(data: Int)
}

class SearchTableViewController: UITableViewController {

 
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var lifeForm = [LifeForm]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return lifeForm.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LifeForms", for: indexPath)
        
        let currentResult = lifeForm[indexPath.row]
    
        var content = cell.defaultContentConfiguration()
        
        content.text = currentResult.title
        content.secondaryText = String(currentResult.id) 
        cell.contentConfiguration = content
        
        return cell
    }
    
    func getResults() {
        let searchText = searchBar.text ?? ""
        
        let InfoRequest = DataInfoRevquest(searchText: searchText)
        
        Task {
            do {
                let Info = try await sendRequest(InfoRequest)
                lifeForm = Info.results
                tableView.reloadData()
                print(Info.results)
            } catch {
                print(error)
            }
        }
    }
    

    
    
    @IBSegueAction func segue(_ coder: NSCoder, sender: Any?) -> DetailViewController? {
        let row = tableView.indexPathForSelectedRow!.row
        
        let sendId = lifeForm[row].id
        print("send Id was sent")
        return DetailViewController(id: sendId, coder: coder)

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
extension SearchTableViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        getResults()
        searchBar.resignFirstResponder()
    }
}
