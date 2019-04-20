//
//  ProductTableViewCell.swift
//  Saucepan
//
//  Created by Kaltrina UKA on 3/15/19.
//  Copyright © 2019 Kaltrina UKA. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIdLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setProductInformation(id: Int, name: String, image: String){
        productIdLabel.text = "Id: \(id)"
        productNameLabel.text = name
        productImageView.image = UIImage(named: image)
    }
    
    
}
