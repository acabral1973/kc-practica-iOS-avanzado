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
    var shopMapImage : String {
        let shopCoordinate = "\(self.shop.latitude!),\(self.shop.longitude!)"
        let googleMapImage = "https://maps.googleapis.com/maps/api/staticmap?center=" + shopCoordinate +  "&zoom=17&size=320x220&scale=2&markers=%7Ccolor:0x9C7B14%7C" + shopCoordinate
        return googleMapImage
    }
    
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
        self.shopMapImage.loadImage(into: shopImage)
    }
}
