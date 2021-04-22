//
//  LoadTableViewCell.swift
//  Test
//
//  Created by Олег Савельев on 23.04.2021.
//

import UIKit

class LoadTableViewCell: UITableViewCell {

    @IBOutlet weak var loadLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.loadLabel.text = "...loading"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
