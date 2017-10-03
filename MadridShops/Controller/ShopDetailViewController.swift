//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 12/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    var shop: Shop!
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var openingLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var shopDetailDescription: UITextView!
    @IBOutlet weak var shopImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.shop.logo.loadImage(into: logoImage)
        self.nameLabel.text = self.shop.name
        self.addressLabel.text = self.shop.address
        self.openingLabel.text = self.shop.openingHours
        self.shopDetailDescription.text = self.shop.description
        self.shop.image.loadImage(into: shopImage)
    }
}
