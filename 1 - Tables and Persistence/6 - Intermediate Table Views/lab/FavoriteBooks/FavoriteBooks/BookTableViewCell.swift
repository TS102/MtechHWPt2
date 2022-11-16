//
//  BookTableViewCell.swift
//  FavoriteBooks
//
//  Created by Tyler Sun on 11/3/22.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!

    func update(with: Book) {
        titleLabel.text = with.title
        authorLabel.text = with.author
        genreLabel.text = with.genre
        lengthLabel.text = with.length
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
