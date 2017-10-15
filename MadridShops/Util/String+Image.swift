//
//  String+Image.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 12/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

extension String {
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: self)  {
                
                OperationQueue.main.addOperation {
                    imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "img_not_available"))
                }
            }
        }
    }
}
