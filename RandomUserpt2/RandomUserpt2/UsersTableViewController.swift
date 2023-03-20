//
//  UsersTableViewController.swift
//  RandomUserpt2
//
//  Created by Tyler Sun on 2/27/23.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var users = [User]()
    
    var link: String
    
    init?(link: String, coder: NSCoder) {
        self.link = link
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserName()
//        getMultipleUsers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UsersTableViewCell
         
        let user = users[indexPath.row]
        
        cell.cellUpdate(user: user)
        
        Task {
            do {
                cell.userImage.image = try await fetchImage(from: URL(string: user.picture!.medium!)!)
                
            } catch {
                print(error)
        }
        }
        return cell
    }

    func getUserName() {
        Task {
            do {
                let info = try await sendRequest(GetUser(query: link))
                users = info.results
                tableView.reloadData()
            }
            catch {
                print(error)
            }
        }
    }
    
    func getMultipleUsers() {
        Task {
            do {
                let info = try await sendRequest(GetMultipleUsers())
                users = info.results
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
    }
    
}
