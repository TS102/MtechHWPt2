//
//  SettingsViewController.swift
//  RandomUserpt2
//
//  Created by Tyler Sun on 2/27/23.
//

import UIKit

class SettingsViewController: UIViewController {
        
    var settingsData: [Int: Bool] = [
          1: false,
          3: false,
          4: false,
          5: false,
          6: false,
          7: false,
          8: false,
          9: false,
          10: false
      ]
      
      let assignedSettings: [Int: String] = [
          1: "gender",
          3: "email",
          4: "login",
          5: "registered",
          6: "dob",
          7: "phone",
          8: "cell",
          9: "id",
          10: "nat"
      ]
    
    @IBOutlet weak var amountOfUserStepper: UIStepper!
    
    @IBOutlet weak var amountOfUsersLabel: UILabel!
    
  
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        amountOfUsersLabel.text = String(sender.value)

    }
    
    var keysToBSent = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    @IBAction func switchToggled(_ sender: UISwitch) {
        
        let key = sender.tag
        settingsData[key] = sender.isOn
        if let type = assignedSettings[key] {
            keysToBSent.contains(type) ? keysToBSent.removeAll(where: { $0 == type } ) : keysToBSent.append(type)
        }
    }
    
    
    @IBSegueAction func segue(_ coder: NSCoder, sender: Any?) -> UsersTableViewController? {
        var queryString =     "https://randomuser.me/api/?results=\(Int(amountOfUserStepper.value))&inc=name,picture"
        keysToBSent.forEach { value in
            queryString += ",\(value)"
        }
        return UsersTableViewController(link: queryString, coder: coder)
        
    }
    
}
