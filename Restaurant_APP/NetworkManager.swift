//
//  NetworkManager.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 7/31/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Alamofire
struct NetworkingManager {
    static let shared: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }()
}
class Reguest {
    func sendRequest<T: Decodable>( userImage: Data? = nil, method: HTTPMethod, url: String, parameters:[String:Any]? = nil, header: [String:String]?  = nil, completion: @escaping (_ error: Error?, _ response: T?)->Void) {
        NetworkingManager.shared.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,nil)
                case .success(_):
                    if (res.result.value as? Dictionary<String, Any>) != nil{
                        
                        do{
                            guard let data = res.data else { return }
                            let response = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,response)
                        }catch let err{
                            print(err.localizedDescription)
                            print(err)
                            completion(err,nil)
                        }
                    }else{
                        completion(nil,nil)
                    }
                }
        }
        
    }
    func Login(userInfoDict : [String:Any],completion: @escaping (LoginModel?, Error?) -> ()){
        
        let url = login
        
        Alamofire.request(url, method: .post,parameters: userInfoDict,encoding: JSONEncoding.default).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(LoginModel.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
        
    }
    var header = ["Content-Type" : "application/json","Authorization": "RtkIL77sYNBJPsFfcVlqeap74PYzG3JWTcPWqXYJyj9Z3wZbf5SaiS6dHtCiVPXD0YjSPI"]
    
    func RestPAssword(userInfoDict : [String:Any],completion: @escaping (RESTPassword?, Error?) -> ()){
        
        let url = change_password
        
        Alamofire.request(url, method: .post,parameters: userInfoDict,encoding: JSONEncoding.default,headers: header).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(RESTPassword.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
        
    }
    
    func MyLocation(userInfoDict : [String:Any],completion: @escaping (AddreessModel?, Error?) -> ()){
        
        let url = Adrress
        
        Alamofire.request(url, method: .post,parameters: userInfoDict,encoding: JSONEncoding.default,headers: header).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(AddreessModel.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
        
    }
    
    func ShowCatrogy(completion: @escaping (CatrogyModel?, Error?) -> ()){
        
        let url = Categories
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default,headers:header).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(CatrogyModel.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
    }
    func AddCart(userInfoDict : [String:Any],completion: @escaping (AddToCart?, Error?) -> ()){
        
        let url = AddTo_Cart
        
        Alamofire.request(url, method: .post,parameters:userInfoDict, encoding: JSONEncoding.default,headers:["Content-Type" : "application/json","Authorization": "RtkIL77sYNBJPsFfcVlqeap74PYzG3JWTcPWqXYJyj9Z3wZbf5SaiS6dHtCiVPXD0YjSPI"]).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(AddToCart.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
    }
    
    func ShowTOCart(completion: @escaping (ShowCart?, Error?) -> ()){
        
        let url = show_favorites
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default,headers:header).responseJSON { (response) in
            
            switch response.result{
                
            case .success(_):
                
                do{
                    
                    guard let data = response.data else {return}
                    
                    let result = try JSONDecoder().decode(ShowCart.self, from: data)
                    
                    completion(result, nil)
                    
                }catch{
                    completion(nil, error)
                }
                
            case .failure(_):
                completion(nil, response.error)
            }
            
        }
        
    }
    
   class func send<T: Decodable>( userImage: Data? = nil, method: HTTPMethod, url: String, parameters:[String:Any]? = nil, header: [String:String]?  = nil, completion: @escaping (_ error: Error?, _ response: T?)->Void) {
        NetworkingManager.shared.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: header)
            .responseJSON { res -> Void in
                switch res.result
                {
                case .failure(let error):
                    completion(error,nil)
                case .success(_):
                    if (res.result.value as? Dictionary<String, Any>) != nil{
                        
                        do{
                            guard let data = res.data else { return }
                            let response = try JSONDecoder().decode(T.self, from: data)
                            completion(nil,response)
                        }catch let err{
                            print(err.localizedDescription)
                            print(err)
                            completion(err,nil)
                        }
                    }else{
                        completion(nil,nil)
                    }
                }
        }
        
    }
    
}
