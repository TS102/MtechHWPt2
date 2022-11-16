//
//  ScoreTableViewCell.swift
//  Scorekeeper
//
//  Created by Tyler Sun on 11/4/22.
//

import UIKit
protocol ScoreTableViewCellDelegate: AnyObject {
    func stepperChanged(_ controller: ScoreTableViewCell, indexPathRow: Int, stepperValue: Int)
}
class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playernameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!

    weak var delegate: ScoreTableViewCellDelegate?
    
    func update(with player: Player) {
        playernameLabel.text = player.name
        numberLabel.text = String(player.score)
        stepper.value = Double(player.score)
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superview = self.superview as? UITableView else {
            return nil
        }
        let indexPath = superview.indexPath(for:  self)
        return indexPath
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func stepperIsPressed(_ sender: UIStepper) {
        stepper.maximumValue = 99
        stepper.minimumValue = 0
        self.numberLabel.text = Int(sender.value).description
        let row = getIndexPath()?.row
        delegate?.stepperChanged(self, indexPathRow: row!, stepperValue: Int(stepper.value))
    }
    
    
}
