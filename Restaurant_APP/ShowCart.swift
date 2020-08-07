//
//  ShowCart.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation

// MARK: - ShowCart
struct ShowCart: Codable {
    let status: Bool?
    let message: String?
    let data: ShowCartDataClass?
}

// MARK: - DataClass
struct ShowCartDataClass: Codable {
    let currentPage: Int?
    let data: [ShowCartDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?
    
    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - Datum
struct ShowCartDatum: Codable {
    let id: Int?
    let product: ShowCartProduct?
}

// MARK: - Product
struct ShowCartProduct: Codable {
    let id, price, oldPrice, discount: Int?
    let image: String?
    let name, productDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case id, price
        case oldPrice = "old_price"
        case discount, image, name
        case productDescription = "description"
    }
}
