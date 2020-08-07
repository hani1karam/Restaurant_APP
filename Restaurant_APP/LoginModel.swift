//
//  LoginModel.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 7/31/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - LoginVC
struct LoginModel: Codable {
    let status: Bool?
    let message: String?
    let data: LoginModelDataClass?
}

// MARK: - DataClass
struct LoginModelDataClass: Codable {
    let id: Int?
    let name, email, phone: String?
    let image: String?
    let points, credit: Int?
    let token: String?
}
