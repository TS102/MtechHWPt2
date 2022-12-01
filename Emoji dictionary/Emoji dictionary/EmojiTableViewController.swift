//
//  EmojiTableViewController.swift
//  Emoji dictionary
//
//  Created by Tyler Sun on 10/18/22.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    var emojis: [Emoji] = [
           Emoji(symbol: "😀", name: "Grinning Face", description: "A typical smiley face.", usage: "happiness"),
           Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
           Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive"),
           Emoji(symbol: "🧑‍💻", name: "Developer", description: "A person working on a MacBook (probably using Xcode to write iOS apps in Swift).", usage: "apps, software, programming"),
           Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "something slow"),
           Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage: "good memory"),
           Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate of spaghetti.", usage: "spaghetti"),
           Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
           Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
           Emoji(symbol: "📚", name: "Stack of Books",description: "Three colored books stacked on each other.", usage: "homework, studying"),
           Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"), Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness"),
           Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage: "completion")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        // it has to write to file first
        let emojiData = Emoji.loadFromFile()
        emojis = emojiData
        tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojis.count
    }


    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        
        let emoji = emojis[indexPath.row]
        
        cell.update(with: emoji)
        cell.showsReorderControl = true

        return cell
        
    }


    @IBSegueAction func addEditEmoji(_ coder: NSCoder, sender: Any?) -> AddEditEmojiTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let emojiToEdit = emojis[indexPath.row]
            return AddEditEmojiTableViewController(coder: coder,
                                                   emoji: emojiToEdit)
        } else {
            return AddEditEmojiTableViewController(coder: coder,
                                                   emoji: nil)
        }
    }
    
    // MARK: - Table view data source

    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
              let sourceViewController = segue.source as? AddEditEmojiTableViewController,
              let emoji = sourceViewController.emoji else {return}
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojis[selectedIndexPath.row] = emoji
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
            Emoji.saveToFile(emojis: emojis)
        } else {
            let newIndexPath = IndexPath(row: emojis.count, section: 0) // when hitting the save button when adding a new emoji this will save it and create a new cell for you to see.
            emojis.append(emoji)
            Emoji.saveToFile(emojis: emojis)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }


    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return.delete
    }
    
    
    override func tableView(_ tableView: UITableView,
       commit editingStyle: UITableViewCell.EditingStyle,
       forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            emojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: . automatic)
            Emoji.saveToFile(emojis: emojis)
        }
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let moveEmoji = emojis.remove(at: fromIndexPath.row)
        emojis.insert(moveEmoji, at: to.row)
        Emoji.saveToFile(emojis: emojis)
    }

}
