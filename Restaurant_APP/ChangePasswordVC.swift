//
//  ChangePasswordVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseViewController{
    static func instance () -> ChangePasswordVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
    }
    
    @IBOutlet weak var CurrentPassword: UITextField!
    
    @IBOutlet weak var NewPassword: UITextField!
    var restpasswordpresenter: RestPasswordPresenter!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        restpasswordpresenter = RestPasswordPresenter(view: self)
    }
    

    @IBAction func ChangePassOrd(_ sender: Any) {
        let param = ["current_password":CurrentPassword.text ?? "",
                     "new_password":NewPassword.text ?? ""]
        print(param)
        restpasswordpresenter = RestPasswordPresenter(view: self)
        restpasswordpresenter.RestPassword(param: param)

    }
    
    @IBAction func BackToHome(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension ChangePasswordVC:RestPasswordToDo{
    
    
    func showHud() {
        showLoading()
    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
    
        HideLoading()
        
    }
    
    func showError(error: String) {
        print(error)
        HideLoading()
        
    }
}
