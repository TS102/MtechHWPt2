//
//  MenuTableTableViewController.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/8/22.
//

import UIKit
@MainActor
class MenuTableTableViewController: UITableViewController {
    
    var imageLoadDataTask: [IndexPath: Task<Void, Never>] = [:]
    let category: String
    var menuItems = [MenuItem]()
    
    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        
        Task.init {
            do {
                let menuItems = try await MenuController.shared.fetchMenuItems(forCategory: category)
                print("working")
                updateUI(with: menuItems)
            } catch {
                displayError(error, title: "failed to fetch menu items for \(self.category)")
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        MenuController.shared.updateUserActivity(with: .menu(category: category))
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        self.menuItems = menuItems
        self.tableView.reloadData()
    }

    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu", for: indexPath)

        // Configure the cell.
    configure(cell, forItemAt: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        imageLoadDataTask[indexPath]?.cancel()
    }
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
       IndexPath) {
        guard let cell = cell as? MenuItemCell else { return }
        
            let menuItem = menuItems[indexPath.row]
        
            cell.itemName = menuItem.name
            cell.price = menuItem.price
            cell.image = nil
        
            imageLoadDataTask[indexPath] = Task.init {
                if let image = try? await
                   MenuController.shared.fetchImage(from: menuItem.imageURL) {
                    if let currentIndexPath = self.tableView.indexPath(for:
                       cell),
                          currentIndexPath == indexPath {
                        cell.image = image
                    }
                }
                imageLoadDataTask[indexPath] = nil
            }
    }
    
    
    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexPath =
               tableView.indexPath(for: cell) else {
                return nil
            }

            let menuItem = menuItems[indexPath.row]
//        return MenuItemDetailViewController(coder: coder, menuItems:
//               menuItem)
        return MenuItemDetailViewController(coder: coder, menuItems: menuItem)
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
