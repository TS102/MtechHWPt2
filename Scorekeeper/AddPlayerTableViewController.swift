//
//  AddPlayerTableViewController.swift
//  Scorekeeper
//
//  Created by Tyler Sun on 11/3/22.
//

import UIKit

class AddPlayerTableViewController: UITableViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var currentScoreTextField: UITextField!
    @IBOutlet weak var SaveButton: UIButton!
    
    var player: Player?
    
    init?(coder: NSCoder, player: Player?) {
        self.player = player
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveButton.isEnabled = false
    }
    
    func updateSaveButtonState() {
        guard let score = currentScoreTextField.text else {return}
        guard Int(score) != nil, nameTextField.text != nil else { return }
        SaveButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else {return}
        
        let name = nameTextField.text!
        let score = currentScoreTextField.text ?? ""
        player = Player(name: name, score: Int(score)!)
    }

    @IBAction func textFieldChanged(_ sender: Any) {
        updateSaveButtonState()
    }
    
    @IBAction func savedButtonTapped(_ sender: Any) {

    }
    
}
