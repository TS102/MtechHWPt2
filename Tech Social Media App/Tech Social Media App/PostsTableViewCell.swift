//
//  PostsTableViewCell.swift
//  Tech Social Media App
//
//  Created by Tyler Sun on 11/16/22.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postsImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    func update(with posts: Posts) {
        nameLabel.text = posts.userName
        captionLabel.text = posts.caption
        dateLabel.text = posts.date.formatted(date: .abbreviated, time: .omitted)
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
