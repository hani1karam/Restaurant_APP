//
//  CollectionViewCell.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell,reloadCellTitles{
    
    
    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var footer: UIView!
    func reloadTitle(title: String) {
        titleLBL.text = title
    }
    
    
}

