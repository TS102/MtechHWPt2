//
//  FoodTableViewController.swift
//  MealTracker
//
//  Created by Tyler Sun on 10/18/22.
//

import UIKit

class FoodTableViewController: UITableViewController {
    var meals: [Meal] = [
        Meal(name: "Breakfast", food: [Food(name: "Eggs & bacon", description: "scrambled eggs with bacon")]),
        Meal(name: "Lunch", food: [Food(name: "Burger & fries", description: "a cheeseburger and large fry from Five guys")]),
        Meal(name: "Dinner", food: [Food(name: "chicken and pastat", description: "")])
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "\(meals[section].name)"
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Food", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let meal = meals[indexPath.section]
        let food = meal.food[indexPath.row]
        content.text = "\(meal.name) - \(food.name)"
        content.secondaryText = food.description
        
        cell.contentConfiguration = content
        
        return cell

    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return meals.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return meals[section].food.count
    }

}
