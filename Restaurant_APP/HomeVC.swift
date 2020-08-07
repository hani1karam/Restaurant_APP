//
//  HomeVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/1/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
protocol DelegateItemSelected {
    var name: String? {get set}
    var image: String? {get set}
    var price: Double? {get set}
    var id:   Int? {get set}

    
    
}

class HomeVC: BaseViewController,DelegateItemSelected{
        
    @IBOutlet weak var CatrogyVC: UICollectionView!
    @IBOutlet weak var ProductTV: UITableView!
    var catrogyPresenter: CatrogyPresenter!
    var productPresnter: ProductPresnter!
    var cartPresnterToDos:CartPresnter!
    var selectedIndex = 0
     var name: String?
     var image: String?
     var price: Double?
    var index = 0
    var id: Int?
 
    override func viewDidLoad() {
        super.viewDidLoad()
             
        CatrogyVC.delegate = self
        CatrogyVC.dataSource = self
        ProductTV.dataSource = self
        ProductTV.delegate = self
        catrogyPresenter = CatrogyPresenter(view: self)
        catrogyPresenter.ShowCatoragy()
        productPresnter = ProductPresnter(view: self)
        cartPresnterToDos = CartPresnter(view:self)
        productPresnter.ShowProduct()
        CatrogyVC.transform = CGAffineTransform(scaleX:-1,y: 1)
 


    }

 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let Deatils = segue.destination as! DetailsVC
     Deatils.delegate = self
     Deatils.delegate?.name = productPresnter.namesArray[index]
     Deatils.delegate?.image = productPresnter.imageArray[index]
    Deatils.delegate?.price = productPresnter.PriceArray[index]
    Deatils.delegate?.id = productPresnter.idsArray[index]

     
 }

    
    
}
extension HomeVC:CatrogyToDos,ProductPresnterToDos,CartPresnterToDos{
    func showHud() {
        showLoading()

    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        CatrogyVC.reloadData()
        ProductTV.reloadData()
        HideLoading()

    }
    
    func showError(error: String) {
        print(error)
        HideLoading()

    }
    
    
}

extension HomeVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catrogyPresenter.titlesCount()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell

        catrogyPresenter.reloadTitles(cell: cell, index: indexPath.row)
        cell.titleLBL.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)

        if selectedIndex == indexPath.row{
            cell.footer.isHidden = false
            cell.titleLBL.font = UIFont(name: "Cairo-SemiBold", size: 19)
        }else{
            cell.footer.isHidden = true
            cell.titleLBL.font = UIFont(name: "Cairo-Light", size: 19)
            
        }

        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.CatrogyVC.reloadData()
 
    }

}
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productPresnter.titlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL", for: indexPath) as! TableViewCell
        productPresnter.reloadTitles(cell: cell, index: indexPath.row)
        productPresnter.reloadPrice(cell: cell, index: indexPath.row)
        productPresnter.reloadimage(cell: cell, index: indexPath.row)
        cell.AddToCart.tag = indexPath.row
        cell.AddToCart.addTarget(self, action: #selector(subscribeTapped(_:)), for: .touchUpInside)

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 307
    }


    @objc func subscribeTapped(_ sender: UIButton){
        let param = ["product_id": productPresnter.idsArray[sender.tag]]

        cartPresnterToDos.Fav(param: param)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = indexPath.row
        performSegue(withIdentifier: "Home", sender: self)
        
    }
}
 
