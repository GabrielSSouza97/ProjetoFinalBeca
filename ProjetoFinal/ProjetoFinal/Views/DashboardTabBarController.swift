//
//  File.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 29/01/21.
//

import Foundation
import UIKit
import DetalhesMoedas

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            let firstViewController = ListaMoedasViewController()
            firstViewController.tabBarItem = UITabBarItem(title: "Moedas", image: UIImage(named: "moedas.png"), tag: 1)
            let secondViewController = FavoritosViewController()
            secondViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "favoritos.png"), tag: 1)
            let tabBarList = [firstViewController, secondViewController]
            self.tabBar.tintColor = UIColor.orange
            self.tabBar.barTintColor = UIColor.black
            self.viewControllers = tabBarList
    }

    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}
