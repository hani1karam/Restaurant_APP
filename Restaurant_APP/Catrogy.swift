//
//  Catrogy.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/2/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
protocol CatrogyToDos {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
protocol reloadCellTitles {
    func reloadTitle(title: String)
}
protocol reloadCelProudctlTitles {
    func reloadProductTitle(title: String)
}
class CatrogyPresenter {
    private var view: CatrogyToDos?
    private var toDoIndicator = Reguest()
     var catoragt = [Datum]()
    init(view: CatrogyToDos) {
        self.view = view
    }
    func ShowCatoragy(){
        view?.showHud()
        toDoIndicator.sendRequest(method: .get, url: Categories,completion:
            
            {(err,response: CatrogyModel?) in
                if err == nil{
                    guard let data = response?.data?.data else{return}
                    self.catoragt = data.self
                    print(response ?? "")
                    print(self.catoragt.count)
                    self.view?.getDataSuccessfully()
                    
                }
        })
    }
    func titlesCount() -> Int{
        return catoragt.count
    }
    func reloadTitles(cell: reloadCellTitles, index: Int){
        cell.reloadTitle(title: catoragt[index].name ?? "")
        
    }

    

}
