//
//  CartTableView.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CartTableView: UITableViewCell,reloadTitle,reloadImage{
  

    @IBOutlet weak var titleLBL: UILabel!
    @IBOutlet weak var View: UIView!
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UI()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func reloadTitle(title: String) {
        titleLBL.text = title
    }
    func reloadImage(image: ShowCartProduct) {
    
        if let img = URL(string: image.image ?? ""){
                 DispatchQueue.main.async {
                     
                     self.img.kf.setImage(with: img)
                     
                 }
                 
             }
    }
     
    
    func UI() {
        View.backgroundColor = UIColor.white
        contentView.backgroundColor = UIColor.white
        View.layer.cornerRadius = 15.0
        //View.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMaxYCorner]
        View.layer.masksToBounds = false
        View.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        View.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        View.layer.shadowOpacity = 0.8
        
        img.layer.cornerRadius = 15.0
        img.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        
        View.static_shadow(withOffset: CGSize(width: 0, height: 2), color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5))
        
    }
    
    
    
    
}
