//
//  ProductPresnter.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
protocol ProductPresnterToDos {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
protocol reloadTitles {
    func reloadTitle(title: String)
}
protocol reloadProudctlTitles {
    func reloadProductTitle(title: String)
}
protocol reloadProudctlPrice{
    func reloadProductPrice(Price: Double?)
}
protocol reloadCellImage {
    func reloadImage(image: Product)
}
class ProductPresnter{
    private var view: ProductPresnterToDos?
    private var toDoIndicator = Reguest()
    var ProductALL = [Product]()
    var product = [AllProductDataClass]()
    init(view: ProductPresnterToDos) {
        self.view = view
    }
    var idsArray: [Int] {
        get {
            return ProductALL.map { $0.id ?? 0}
        }
    }
    var namesArray: [String] {
        get {
            return ProductALL.map { ($0.name ?? "")}
        }
    }
    var PriceArray: [Double] {
        get {
            return ProductALL.map { ($0.price ?? 0)}
        }
    }
    var imageArray: [String] {
        get {
            return ProductALL.map { ($0.image ?? "" )}
            
        }
    }
    
    func ShowProduct(){
        view?.showHud()
        toDoIndicator.sendRequest(method: .get, url: allproduct,completion:
            
            {(err,response: AllProduct?) in
                if err == nil{
                    guard let data = response?.data?.products else{return}
                    self.ProductALL = data
                    print(response ?? "")
                    print(self.ProductALL.count)
                    self.view?.getDataSuccessfully()
                    
                }
        })
    }
    
    func titlesCount() -> Int{
        return ProductALL.count
    }
    func reloadTitles(cell: reloadTitles, index: Int){
        cell.reloadTitle(title: ProductALL[index].name ?? "")
        
    }
    func reloadPrice(cell: reloadProudctlPrice, index: Int){
        cell.reloadProductPrice(Price: ProductALL[index].price)
        
    }
    func reloadimage(cell: reloadCellImage, index: Int){
        cell.reloadImage(image: ProductALL[index])
    }
    
}
