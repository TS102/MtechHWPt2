//
//  PostsTableViewController.swift
//  Tech Social Media App
//
//  Created by Tyler Sun on 11/2/22.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var posts: [Posts] = [
        Posts(userName: "@Tyler", caption: "This is the very first post.", image: UIImage(named: "Ironman")!, date: Date()),
        Posts(userName: "@SomeGuy", caption: "How i code all the time.", image: UIImage(named: "meme2")!, date: Date()),
        Posts(userName: "@chevy", caption: "My favorite sport is basketball.", image: UIImage(named: "Nba")!, date: Date()),
        Posts(userName: "@ShoesDealer", caption: "I like collecting shoes here is a collection i found online since i'm broke.", image: UIImage(named: "Shoes")!, date: Date()),
        Posts(userName: "@SomeGuy", caption: "Here is another code meme.", image: UIImage(named: "meme1")!, date: Date()),
        Posts(userName: "@PeterParker", caption: "This is my favorite superhero.", image: UIImage(named: "Spiderman 1")!, date: Date()),
        Posts(userName: "@Tyler", caption: "The denver Broncos are my favorite team despite no doing well this season.", image: UIImage(named: "Broncos")!, date: Date()),
        Posts(userName: "@jeff", caption: "I like skateboarding.", image: UIImage(named: "Skateboard")!, date: Date()),
        Posts(userName: "@ElBarto", caption: "I made this it is one of my most proud pieces in my collection. I I am going to turn it into an nft.", image: UIImage(named: "pieceofart")!, date: Date())
    ]

    
    override func viewDidLoad() {
        tableView.backgroundColor = .opaqueSeparator
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    // MARK: - Table view data source


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostsCell", for: indexPath) as! PostsTableViewCell
        let post = posts[indexPath.row]
        cell.backgroundColor = .opaqueSeparator
        cell.postsImage.image = post.image
        cell.update(with: post)
        // Configure the cell...


        return cell
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
