//
//  MenuTabBar.swift
//  Restaurant_APP
//
//  Created by Hany Karam on 8/3/20.
//  Copyright © 2020 Hany Karam. All rights reserved.
//

import UIKit

class MenuTabBar: UITabBarController {
    static func instance () -> MenuTabBar {
         let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
         return storyboard.instantiateViewController(withIdentifier: "MenuTabBar") as! MenuTabBar
     }
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.selectedIndex = 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
