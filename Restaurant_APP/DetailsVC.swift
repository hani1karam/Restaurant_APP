//
//  DetailsVC.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/3/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit
import Kingfisher
class DetailsVC: UIViewController {
    var delegate: DelegateItemSelected?

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var namefood: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var Vieww: UIView!
    @IBOutlet weak var CounterCart: UILabel!

    var cartPresnterToDos:CartPresnter!
    var productPresnter: ProductPresnter!


    override func viewDidLoad() {
        super.viewDidLoad()

        Vieww.backgroundColor = UIColor.white
               Vieww.layer.cornerRadius = 3.0
               Vieww.layer.masksToBounds = false
               Vieww.layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
               Vieww.layer.shadowOffset = CGSize(width: 0, height: 0)
               Vieww.layer.shadowOpacity = 0.8
        cartPresnterToDos = CartPresnter(view:self)

        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let item = delegate {
            self.namefood.text = item.name
            self.image.kf.setImage(with: URL(string:item.image ?? ""))
              self.price.text = "\(item.price ?? 0)"
            
            
        }
        
    }
    

    @IBAction func Add(_ sender: Any) {
        guard var counter = Int(self.CounterCart.text!) else {return}
        counter += 1
        self.CounterCart.text = "\(counter)"

    }
    
    @IBAction func increase(_ sender: Any) {
        guard var counter = Int(self.CounterCart.text!) else {return}
        counter -= 1
        self.CounterCart.text = "\(counter)"

    }
    @IBAction func AddToCart(_ sender: Any) {
        
//let param = ["product_id": productPresnter.idsArray[(delegate?.id)!]]
        let param = ["product_id":"22"]
         cartPresnterToDos.Fav(param: param)

        
    }
    
    @IBAction func CartHome(_ sender: Any) {
        let Home = CartVC.instance()
        Home.modalPresentationStyle = .fullScreen
        self.present(Home, animated: true, completion: nil)

    }
    
}
extension DetailsVC:CartPresnterToDos{
    func showHud() {
        
    }
    
    func HideHud() {
        
    }
    
    func getDataSuccessfully() {
        
    }
    
    func showError(error: String) {
        
    }
    
    
}
