//
//  RepresentativesableViewCell.swift
//  Dogs&Politics
//
//  Created by Tyler Sun on 12/2/22.
//

import UIKit

class RepresentativesableViewCell: UITableViewCell {

    @IBOutlet weak var repName: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
