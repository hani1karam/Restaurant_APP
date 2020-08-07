//
//  ViewController.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 7/31/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import FBSDKLoginKit
class LoginVC:BaseViewController,LoginButtonDelegate{
    
    
    
    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBOutlet weak var FaceBookButton: FBLoginButton!
    
    var presenter: Presenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let token = AccessToken.current,!token.isExpired {
            // User is logged in, do work such as go to next view controller.
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
            request.start(completionHandler: {connection , result,error in
                print(result ?? "")
                
            })
        }
        else{
            presenter = Presenter(view: self)
            presenter = Presenter(Home: self)
            //FaceBook
            let loginButton = FaceBookButton
            loginButton?.delegate = self
            loginButton?.permissions = ["public_profile", "email"]
            loginButton?.heightAnchor.constraint(equalToConstant: 91).isActive = true
            view.addSubview(loginButton!)
            
        }
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        let param = ["email":NameTextField.text ?? "",
                     "password":PasswordTextField.text ?? ""]
        NetworkHelper.token = presenter.loginModel?.data?.token ?? ""
        presenter = Presenter(view: self)
        presenter.login(param: param)
        
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
        request.start(completionHandler: {connection , result,error in
            print(result ?? "")
            
        })
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    @IBAction func RegisterButton(_ sender: Any) {
        let Home = RegisterVC.instance()
        Home.modalPresentationStyle = .fullScreen
        self.present(Home, animated: true, completion: nil)
        
    }
    
}

extension LoginVC:getToDos{
    
    
    func showHud() {
        showLoading()
    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        if (presenter.loginModel?.status == true){
            let Home = MenuTabBar.instance()
            Home.modalPresentationStyle = .fullScreen
            self.present(Home, animated: true, completion: nil)
            
        }
        HideLoading()
        
    }
    
    func showError(error: String) {
        print(error)
        HideLoading()
        
    }
}
