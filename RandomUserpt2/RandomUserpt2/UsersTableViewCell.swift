//
//  UsersTableViewCell.swift
//  RandomUserpt2
//
//  Created by Tyler Sun on 3/1/23.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var natLabel: UILabel!
    @IBOutlet weak var registeredLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func cellUpdate(user: User) {
  
        if let firstName = user.name?.first,
           let lastName = user.name?.last {
            nameLabel.text = "\(firstName) \(lastName)"
        }
        
        if let dob = user.dob?.age {
            dobLabel.text = "Age: \(dob)"
        } else {
            dobLabel.isHidden = false
        }
        
        if let gender = user.gender {
            genderLabel.text = gender
        } else {
            genderLabel.isHidden = false
        }
        
        if let phone = user.phone {
            phoneLabel.text = phone
        } else {
            phoneLabel.isHidden = false
        }
        
        if let login = user.login?.userName {
            loginLabel.text = login
        } else {
            loginLabel.isHidden = false
        }
        
        if let cell = user.cell {
            cellLabel.text = cell
        } else {
            cellLabel.isHidden = false
        }
        
        if let email = user.email {
            emailLabel.text = email
        } else {
            emailLabel.isHidden = false
        }
        
        if let id = user.id?.name {
            idLabel.text = id
        } else {
            idLabel.isHidden = false
        }
        
        if let registered = user.registered?.age {
            registeredLabel.text = "Registration Num: \(registered)"
        } else   {
            registeredLabel.isHidden = false
        }
        
        if let nat = user.nat {
            natLabel.text = nat
        } else {
            natLabel.isHidden = false
        }
    }

}
