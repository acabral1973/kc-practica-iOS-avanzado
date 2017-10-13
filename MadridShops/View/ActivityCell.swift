//
//  ActivityCell.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 25/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

class ActivityCell: UICollectionViewCell {
    var activity: Activity?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    func refresh(activity: Activity) {
        self.activity = activity
        
        self.nameLabel.text = activity.name
        self.addressLabel.text = activity.address
        self.activity?.image.loadImage(into: imageView)
    }
}
