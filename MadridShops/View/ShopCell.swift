//
//  ShopCell.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 08/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

class ShopCell: UICollectionViewCell {
    var shop: Shop?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    

    func refresh(shop: Shop) {
        self.shop = shop
        self.nameLabel.text = shop.name
        self.addressLabel.text = shop.address
        self.shop?.image.loadImage(into: imageView)
    }
}
