//
//  ProductCell.swift
//  Foodies
//
//  Created by Fhict on 12/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var quantTB: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
