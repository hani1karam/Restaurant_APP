//
//  ProfielPresnter.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import Foundation
protocol ProfielToDo {
    func showHud()
    func HideHud()
    func getDataSuccessfully()
    func showError(error: String)
}
class ProfielPresenter{
    private var view: ProfielToDo?
    weak var Home: HomeVC?
    private var toDoIndicator = Reguest()
    var profiel:ProfielModel?
    init(view: ProfielToDo) {
        self.view = view
    }
    var header = ["Content-Type" : "application/json"  ,"Authorization": "a3OFG4il9UuXhtECKQUQgeKRqaf7DngM1IQo1gJXwlhSxgqk08wsosVR3LehGb4JFZDUJu"]
    func Profiel(Name:String){
        view?.showHud()
        toDoIndicator.sendRequest(method: .get, url: profiel_info,header:header,completion:
            
            {(err,response: ProfielModel?) in
                if err == nil{
                    guard var data = response?.data else{return}
                    data.name = Name
                    print(response ?? "")
                
                    self.view?.getDataSuccessfully()
                    
                }
        })
    }


    

}
