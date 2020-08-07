//
//  Presnter.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 7/31/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//
//algazzar.abdelrahman@gmail.com
import UIKit

protocol getToDos {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
class Presenter{
    private var view: getToDos?
    weak var Home: LoginVC?

    private var toDoIndicator = Reguest()
     var loginModel:LoginModel?
    init(view: getToDos) {
        self.view = view
    }
    init(Home: LoginVC) {
        self.Home = Home
    }
    func login(param:[String:Any]){
        view?.showHud()
    toDoIndicator.Login(userInfoDict:param){(response, error) in
        self.Home?.showLoading()
            print(response ?? "")
            if error == nil{
                self.Home?.HideLoading()
                self.showToast(message: response?.message ?? "")
                guard let response = response else {return}
                self.loginModel = response
                self.view?.getDataSuccessfully()
                return
            }
            else {
                self.Home?.HideLoading()
                self.showToast(message: response?.message ?? "")
            }
            
        }
    }
    
}
extension Presenter {
    
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
 
