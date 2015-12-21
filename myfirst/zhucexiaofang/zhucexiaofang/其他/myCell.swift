//
//  myCell.swift
//  zhucexiaofang
//
//  Created by shanghongzhi on 15/12/7.
//  Copyright © 2015年 shz. All rights reserved.
//

import UIKit

class myCell: UITableViewCell {
    @IBOutlet var pageImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
