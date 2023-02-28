//
//  RandomUserViewController.swift
//  randomUser
//
//  Created by Tyler Sun on 2/27/23.
//

import UIKit

class RandomUserViewController: UIViewController {
    
    var user: [User] = []
    
    
    @IBOutlet weak var userLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let randomUser = user.randomElement() {
            userLabel.text = "User is \(randomUser.name)"
        }
    }
    
    @IBAction func dismissButtonTapped() {
        dismiss(animated: true)
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
