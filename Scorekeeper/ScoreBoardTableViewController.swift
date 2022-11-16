//
//  ScoreBoardTableViewController.swift
//  Scorekeeper
//
//  Created by Tyler Sun on 11/3/22.
//

// making outlets for the tableviewcontroller

import UIKit


class ScoreBoardTableViewController: UITableViewController, ScoreTableViewCellDelegate {
    func stepperChanged(_ controller: ScoreTableViewCell, indexPathRow: Int, stepperValue: Int) {
        players[indexPathRow].score = stepperValue
        sortCells()
        tableView.reloadData()
    }
    

        
    var players: [Player] = [
    Player(name: "jo", score: 12),
    Player(name: "tyler", score: 21)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortCells()

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as! ScoreTableViewCell
        
        let player = players[indexPath.row]
//        sortCells()
        cell.delegate = self
        cell.update(with: player)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
    }
    
    func sortCells() {
        players.sort { $0.score > $1.score }
        tableView.reloadData()
    }
    
    // MARK: - Navigation

    @IBSegueAction func addPlayer(_ coder: NSCoder, sender: Any?) -> AddPlayerTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexpath = tableView.indexPath(for: cell) {
            let playerToEdit = players[indexpath.row]
            return AddPlayerTableViewController(coder: coder, player: playerToEdit)
        } else {
            return AddPlayerTableViewController(coder: coder, player: nil)
        }
    }
    
    @IBAction func unwindToScoreBoard(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind",
            let source = segue.source as? AddPlayerTableViewController,
              let player = source.player else { return }
        if let indexPath = tableView.indexPathForSelectedRow {
            players[indexPath.row] = player
            tableView.reloadRows(at: [indexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: players.count, section: 0)
            players.append(player)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        sortCells()
    }
    
 
}
