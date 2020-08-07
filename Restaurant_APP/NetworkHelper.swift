//
//  NetworkHelper.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
class NetworkHelper {
    
    static var token: String?{
        didSet{
            UserDefaults.standard.set(token, forKey: "token")
        }
    }
    
    static func getAccessToken() -> String? {
        if let accessToken = UserDefaults.standard.value(forKey: "token") as? String{
            NetworkHelper.token = accessToken
            print("token:\(accessToken)")
        }
        return NetworkHelper.token
    }
}
