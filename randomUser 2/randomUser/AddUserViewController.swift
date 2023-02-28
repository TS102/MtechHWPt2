//
//  AddUserViewController.swift
//  randomUser
//
//  Created by Tyler Sun on 2/24/23.
//

import UIKit

class AddUserViewController: UIViewController {
    
    @IBOutlet weak var addUserTextfeld: UITextField!
    
    var newUser: User?
    
    init?(coder: NSCoder, newUser: User?) {
        self.newUser = newUser
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let user = newUser else { return }
        addUserTextfeld.text = user.name
        // Do any additional setup after loading the view.
    }
    
    func textFieldEmpty() {
        UIView.animate(withDuration: 0.1) {
            self.addUserTextfeld.transform = CGAffineTransform(translationX: 2, y: 0)
        }
        self.addUserTextfeld.transform = .identity
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let textField = addUserTextfeld.text else { return }
        if textField.isEmpty {
            textFieldEmpty()
        } else {
            guard let user = addUserTextfeld.text else { return }
            newUser = User(name: user)
            performSegue(withIdentifier: "Unwind", sender: self)
            print("Unwind worked")
        }
    }
}
