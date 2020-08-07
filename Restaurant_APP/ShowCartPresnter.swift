//
//  ShowCartPresnter.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
protocol ShowCartPresnterToDO {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
protocol reloadTitle {
    func reloadTitle(title: String)
}
protocol reloadImage {
    func reloadImage(image: ShowCartProduct)
}

class ShowCartPresnter{
    private var view: ShowCartPresnterToDO?
    weak var Home: CartVC?
    public var FavProductitem = [ShowCartDatum]()
    private var toDoIndicator = Reguest()
    var loginModel:ShowCart?
    
    init(view: ShowCartPresnterToDO) {
        self.view = view
    }
    
    func ShowCart(){
        toDoIndicator.ShowTOCart(){ [weak self] (response, error) in
            self?.Home?.showLoading()
            
            print(response ?? "")
            if error != nil{
                self?.Home?.HideLoading()
                
                self?.showToast(message: response?.message ?? "")
                
                print(error ?? "")
                return
            }
            self?.showToast(message: response?.message ?? "")
            
            guard let response = response?.data?.data else {return}
            self?.FavProductitem = response
            
            self?.view?.getDataSuccessfully()
        }
        
    }
    func titlesCount() -> Int{
        return FavProductitem.count
    }
    func reloadTitles(cell: reloadTitle, index: Int){
        cell.reloadTitle(title: FavProductitem[index].product?.name ?? "")
        
    }
    func reloadImage(cell: reloadImage, index: Int){
        cell.reloadImage(image: FavProductitem[index].product!)
    }
    
    
}
extension ShowCartPresnter{
    
    func showToast(message: String) {
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let toastLbl = UILabel()
        toastLbl.text = message
        toastLbl.textAlignment = .center
        toastLbl.font = UIFont.systemFont(ofSize: 18)
        toastLbl.textColor = UIColor.white
        toastLbl.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLbl.numberOfLines = 0
        
        
        let textSize = toastLbl.intrinsicContentSize
        let labelHeight = ( textSize.width / window.frame.width ) * 30
        let labelWidth = min(textSize.width, window.frame.width - 40)
        let adjustedHeight = max(labelHeight, textSize.height + 20)
        
        toastLbl.frame = CGRect(x: 20, y: (window.frame.height - 90 ) - adjustedHeight, width: labelWidth + 20, height: adjustedHeight)
        toastLbl.center.x = window.center.x
        toastLbl.layer.cornerRadius = 10
        toastLbl.layer.masksToBounds = true
        
        window.addSubview(toastLbl)
        
        UIView.animate(withDuration: 3.0, animations: {
            toastLbl.alpha = 0
        }) { (_) in
            toastLbl.removeFromSuperview()
            
            
            
        }
    }
    
}

