//
//  BookTableViewCell.swift
//  GoogleBookAPI
//
//  Created by Karen Fuentes on 12/4/16.
//  Copyright © 2016 Karen Fuentes. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNailImage: UIImageView!
    @IBOutlet weak var BookTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
