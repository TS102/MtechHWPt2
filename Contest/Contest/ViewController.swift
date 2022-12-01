//
//  ViewController.swift
//  Contest
//
//  Created by Tyler Sun on 11/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func noEmailAnimation() {
        UIView.animate(withDuration: 0.1) {
            self.emailTextField.transform = CGAffineTransform(translationX: 2, y: 0)
        }
        self.emailTextField.transform = .identity
    }
    

    @IBAction func submitButton(_ sender: Any) {
        guard let textField = emailTextField.text else { return }
        if textField.isEmpty {
            noEmailAnimation()
        } else {
            self.performSegue(withIdentifier: "EmailGood", sender: sender)
        }
    }
    
}

