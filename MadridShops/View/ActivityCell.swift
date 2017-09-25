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
    @IBOutlet weak var label: UILabel!
    
    func refresh(activity: Activity) {
        self.activity = activity
        
        self.label.text = activity.name
        self.activity?.logo.loadImage(into: imageView)
        imageView.clipsToBounds = true
        UIView.animate(withDuration: 1.0) {
            self.imageView.layer.cornerRadius = 30
        }
    }
}
