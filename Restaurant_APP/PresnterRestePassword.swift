//
//  PresnterRestePassword.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

protocol RestPasswordToDo {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
class RestPasswordPresenter{
    private var view: RestPasswordToDo?
    weak var Home: ChangePasswordVC?
    private var toDoIndicator = Reguest()
    var restPassword:RESTPassword?
    init(view: RestPasswordToDo) {
        self.view = view
    }

    func RestPassword(param:[String:Any]){
        view?.showHud()
        toDoIndicator.RestPAssword(userInfoDict:param){(response, error) in
            self.Home?.showLoading()
            print(response ?? "")
            if error == nil{
                self.Home?.HideLoading()
                self.showToast(message: response?.message ?? "")
                guard let response = response else {return}
                self.restPassword = response
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
extension RestPasswordPresenter {
    
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

