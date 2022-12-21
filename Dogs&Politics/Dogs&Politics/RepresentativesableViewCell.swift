//
//  RepresentativesableViewCell.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/2/22.
//

import UIKit

class RepresentativesableViewCell: UITableViewCell {
    
    @IBOutlet weak var repsNameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override func updateConfiguration(using state: UICellConfigurationState) {
//        var content = defaultContentConfiguration().updated(for: state)
//
//        repsNameLabel.text = name
//        partyLabel.text = party
//        linkLabel.text = link
//
//
//
//    }

}
