//
//  RestePassword.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
// MARK: - RESTPassword
struct RESTPassword: Codable {
    let status: Bool?
    let message: String?
    let data: RESTPasswordDataClass?
}

// MARK: - DataClass
struct RESTPasswordDataClass: Codable {
    let email: String?
}
