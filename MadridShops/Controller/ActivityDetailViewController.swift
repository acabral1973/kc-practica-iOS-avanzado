//
//  ActivityDetailViewController.swift
//  MadridShops
//
//  Created by Alejandro Cabral Benavente on 26/9/17.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var activity: Activity!
    
    @IBOutlet weak var activityImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var openingLabel: UILabel!
    @IBOutlet weak var activityDetailDescription: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activity.activityMapImage.loadImage(into: activityImage)
        self.nameLabel.text = self.activity.name
        self.addressLabel.text = self.activity.address
        self .openingLabel.text = self.activity.openingHours
        self.activityDetailDescription.text = self.activity.description
    }
}
