//
//  AllProduct.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - AllProduct
struct AllProduct: Codable {
    let status: Bool?
    let message: String?
    let data: AllProductDataClass?
}

// MARK: - DataClass
struct AllProductDataClass: Codable {
    let banners: [Banner]?
    let products: [Product]?
    let ad: String?
}

// MARK: - Banner
struct Banner: Codable {
    let id: Int?
    let image: String?
    let category, product: String?
}

// MARK: - Product
struct Product: Codable {
    let id: Int?
    let price: Double?
    let oldPrice: Double?
    let discount: Int?
    let image: String?
    let name, productDescription: String?
    let images: [String]?
    let inFavorites, inCart: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
        case images
        case inFavorites = "in_favorites"
        case inCart = "in_cart"
    }
}
