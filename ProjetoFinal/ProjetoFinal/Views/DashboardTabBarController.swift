//
//  File.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 29/01/21.
//

import Foundation
import UIKit
import DetalhesMoedas
import CommonsService

class DashboardTabBarController: UITabBarController, UITabBarControllerDelegate {

    var moedasFavoritos: Array<Moeda> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            let firstViewController = ListaMoedasViewController()
            firstViewController.tabBarItem = UITabBarItem(title: "Moedas", image: UIImage(named: "moedas.png"), tag: 1)
            let secondViewController = FavoritosViewController(moedaFavorito: moedasFavoritos)
            secondViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "favoritos.png"), tag: 1)
            let tabBarList = [firstViewController, secondViewController]
            self.tabBar.tintColor = UIColor.orange
            self.tabBar.barTintColor = UIColor.black
            self.viewControllers = tabBarList

    }
    
}
