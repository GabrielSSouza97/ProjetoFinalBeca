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
        var firstViewController: ListaMoedasViewController
        var secondViewController: FavoritosViewController
        
        init(_ first:ListaMoedasViewController = ListaMoedasViewController()) {
            self.firstViewController = first
            self.secondViewController = FavoritosViewController()
            
            print("init \(self.firstViewController.moedas)")
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
            //let firstViewController = ListaMoedasViewController()
        
            firstViewController.tabBarItem = UITabBarItem(title: "Moedas", image: UIImage(named: "moedas.png"), tag: 1)
        
            //let secondViewController = FavoritosViewController()
        
            secondViewController.tabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "favoritos.png"), tag: 1)
            let tabBarList = [firstViewController, secondViewController]
            self.tabBar.tintColor = UIColor.orange
            self.tabBar.barTintColor = UIColor.black
            self.viewControllers = tabBarList
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            if(item.title == "Favoritos"){
                //inicia defaults
                let defaults = UserDefaults.standard
                //lista de favoritos
                let listaFavoritos = defaults.object(forKey:"ListaFavoritos") as? [String] ?? [String]()
                //crio uma lista vazio para os favoritos
                var moedas = [Moeda]()
                
                guard let moedasFavoritos = firstViewController.moedas as? Array<Moeda> else { return }
                
                //se houver algum item da lista
                if(listaFavoritos.count > 0) {
                    for item in moedasFavoritos {
                        for itemFavorito in listaFavoritos {
                            if(item.siglaMoeda == itemFavorito) {
                                moedas.append(item)
                            }
                        }
                    }
                }
                
                secondViewController.moedaFavorito = moedas
                
            } else {

            }
        }
}
