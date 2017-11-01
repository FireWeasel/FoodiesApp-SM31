//
//  ProductCell.swift
//  Foodies
//
//  Created by Fhict on 12/10/2017.
//  Copyright © 2017 Fhict. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var quantityLb: UILabel!
    @IBOutlet weak var quantitySpin: UIStepper!
    @IBOutlet weak var buttonAddToCart: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageViewProduct: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        buttonAddToCart.layer.cornerRadius = 4
    }

    @IBAction func actionTriggered(_ sender: Any) {
        let value = quantitySpin.value
        quantityLb.text = String(Int(value))
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
