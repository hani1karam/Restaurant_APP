//
//  RegisterModel.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - RegisterVC
struct RegisterModel: Codable {
    let status: Bool?
    let message: String?
    let data: RegisterVCDataClass?
}

// MARK: - RegisterVCDataClass
struct RegisterVCDataClass: Codable {
    let name, phone, email: String?
    let id: Int?
    let image: String?
    let token: String?
}
