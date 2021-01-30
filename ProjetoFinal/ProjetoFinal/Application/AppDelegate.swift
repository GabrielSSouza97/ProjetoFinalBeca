//
//  AppDelegate.swift
//  ProjetoFinal
//
//  Created by Leticia Sousa Siqueira on 21/01/21.
//

import UIKit
import DetalhesMoedas

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  //  var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        MoedaDAO.shared
        
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.rootViewController = UINavigationController(rootViewController: DashboardTabBarController())
//        window?.makeKeyAndVisible()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) { }

    func applicationDidEnterBackground(_ application: UIApplication) { }

    func applicationWillEnterForeground(_ application: UIApplication) { }

    func applicationDidBecomeActive(_ application: UIApplication) { }

    func applicationWillTerminate(_ application: UIApplication) { }
}


