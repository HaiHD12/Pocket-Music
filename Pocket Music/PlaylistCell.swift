//
//  PlaylistCell.swift
//  Pocket Music
//
//  Created by Hai Duong on 12/8/18.
//  Copyright © 2018 Hai Duong. All rights reserved.
//

import UIKit

class PlaylistCell: UITableViewCell {


    @IBOutlet weak var ArtistLabel: UILabel!
    @IBOutlet weak var SongLabel: UILabel!
    @IBOutlet weak var CoverImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
