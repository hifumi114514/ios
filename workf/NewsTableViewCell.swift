//
//  NewsTableViewCell.swift
//  workf
//
//  Created by 周子康 on 2021/5/27.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var TittleLabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var ImageShow: UIImageView!
}
