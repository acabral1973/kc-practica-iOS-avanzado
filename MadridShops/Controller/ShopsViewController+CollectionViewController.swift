//
//  ShopsViewController+CollectionViewController.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 07/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import UIKit

extension ShopsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShopCell", for: indexPath) as! ShopCell
        
        let shopCD: ShopCD = fetchedResultsController.object(at: indexPath)
        
        cell.refresh(shop: mapShopCDIntoShop(shopCD: shopCD))
        
        return cell
    }
    
    
}
