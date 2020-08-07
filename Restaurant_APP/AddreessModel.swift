//
//  AddreessModel.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - AddreessModel
struct AddreessModel: Codable {
    let status: Bool?
    let message: String?
    let data: AddreessModelDataClass?
}

// MARK: - AddreessModelDataClass
struct AddreessModelDataClass: Codable {
    let name, city, region, details: String?
    let latitude, longitude: Double?
    let notes: String?
    let id: Int?
}
