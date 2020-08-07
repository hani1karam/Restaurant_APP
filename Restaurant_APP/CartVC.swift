//
//  CartVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/4/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class CartVC: BaseViewController,UITableViewDelegate,UITableViewDataSource{
  static func instance () -> CartVC {
       let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
       return storyboard.instantiateViewController(withIdentifier: "CartVC") as! CartVC
   }

    
    
    @IBOutlet weak var CartTV: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var showCartPresnter:ShowCartPresnter!
    var searchResultArray = [SearchModelDatum]()
        var searchedCountry = [String]()
        var searching = false
        var dataArray = [String]()

    var filteredArray = [String]()

    var shouldShowSearchResults = false

    override func viewDidLoad() {
        super.viewDidLoad()
        CartTV.dataSource = self
        CartTV.delegate = self
        showCartPresnter = ShowCartPresnter(view: self)
        showCartPresnter.ShowCart()
        if let textFieldInsideSearchBar  = searchBar.value(forKey: "searchField") as? UITextField{
                textFieldInsideSearchBar.font = textFieldInsideSearchBar.font?.withSize(13)
                if let textField = textFieldInsideSearchBar.subviews.first{
                    textField.backgroundColor = .white
                    textField.layer.cornerRadius = 6
                    textField.clipsToBounds = true
                }
            }
             if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
                textfield.textAlignment = .right
                textfield.textColor = UIColor(red: 55/255, green: 97/255, blue: 116/255, alpha: 1)
            }

 
    }
    
       func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
           guard let keywords = searchBar.text else { return }
           search(keyword: keywords)
           self.view.endEditing(true)
       }
    
       func search(keyword: String) {
            let headers = ["Authorization": "I5B5uuTH5ueaugdwIiETTnycnLUZ9M9iiVWZ0SSc8cTGNU2VlJZM2AF3ipJmbzLDBN77gv"]

           Reguest.send(method: .post, url: "https://student.valuxapps.com/api/products/search",parameters: ["text": keyword],header:headers ,completion: { (err, response: SearchModel?) in
                if err == nil{
                   if response!.status{
                       guard let result = response?.data.data else{return}
                       self.searchResultArray = result
                       self.CartTV.reloadData()
                   }
               }
           })
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showCartPresnter.titlesCount()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CartTableView
        showCartPresnter.reloadTitles(cell: cell, index: indexPath.row)
        showCartPresnter.reloadImage(cell: cell, index: indexPath.row)

        return cell
     }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 174
    }
    
    @IBAction func Back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
extension CartVC:ShowCartPresnterToDO{
    func showHud() {
        showLoading()

    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        CartTV.reloadData()
         HideLoading()

    }
    
    func showError(error: String) {
        print(error)
        HideLoading()

    }


}
extension CartVC: UISearchBarDelegate {
    
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
           searching = true
    
           CartTV.reloadData()
       }
       
       func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
           searching = false
           searchBar.text = ""
           searchBarSearchButtonClicked(searchBar)
           CartTV.reloadData()
       }
    
}
