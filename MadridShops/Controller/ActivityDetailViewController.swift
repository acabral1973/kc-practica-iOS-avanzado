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
    
    @IBOutlet weak var activityDetailDescription: UITextView!
    @IBOutlet weak var activityImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.activity.name
        self.activityDetailDescription.text = self.activity.description
        self.activity.image.loadImage(into: activityImage)
    }
}
