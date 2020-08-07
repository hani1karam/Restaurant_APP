//
//  ProfielModel.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - ProfielModel
struct ProfielModel: Codable {
    let status: Bool?
    let message: String?
    let data: ProfielModelDataClass?
}

// MARK: - ProfielModelDataClass
struct ProfielModelDataClass: Codable {
    let id: Int?
    var name, email, phone: String?
    let image: String?
    let points, credit: Int?
    let token: String?
}
