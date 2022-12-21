//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Tyler Sun on 12/15/22.
//

import UIKit

class OrderConfirmationViewController: UIViewController {

    @IBOutlet weak var confirmationLabel: UILabel!
    
    let minutesLeftToPrepare: Int
    
    init?(coder: NSCoder, minutesLeftToPrepare: Int) {
        self.minutesLeftToPrepare = minutesLeftToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesLeftToPrepare) minutes."
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
