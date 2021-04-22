//
//  TableViewCell.swift
//  Test
//
//  Created by Олег Савельев on 20.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownedLoginLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func initCell(item: Repository){
        self.idLabel.text = String(item.id)
        self.nameLabel.text = item.name
        self.ownedLoginLabel.text = item.owner.login
        self.descriptionLabel.text = item.description
    }

}
