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
    @IBOutlet weak var label: UILabel!

    func refresh(shop: Shop) {
        self.shop = shop
        self.label.text = shop.name
        self.shop?.logo.loadImage(into: imageView)
        
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 30
        }
    }
}
