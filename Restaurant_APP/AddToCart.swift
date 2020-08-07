//
//  AddToCart.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/3/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - AddToCart
struct AddToCart: Codable {
    let status: Bool?
    let message: String?
    let data: AddToCartDataClass?
}

// MARK: - DataClass
struct AddToCartDataClass: Codable {
    let id: Int?
    let product: AddToCartProduct?
}

// MARK: - Product
struct AddToCartProduct: Codable {
    let id, price, oldPrice, discount: Int?
    let image: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image
    }
}
