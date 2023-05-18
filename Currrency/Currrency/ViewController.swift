//
//  ViewController.swift
//  Currrency
//
//  Created by Linh on 18/05/2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.initTabbar()
        }
        // Do any additional setup after loading the view.
    }
    
    private func initTabbar(){
        let homeVC = HomeViewController()
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "home-tabbar"), tag: 0)
//        homeVC.tabBarItem.selectedImage = UIImage(named: "home-tabbar-selected")
        
        
        let fearIndexVC = FearIndexViewController()
        fearIndexVC.tabBarItem = UITabBarItem(title: "Index", image: #imageLiteral(resourceName: "index-tabbar"), tag: 0)
//        fearIndexVC.tabBarItem.selectedImage = UIImage(named: "index-tabbar-selected")
        
        
        let portfolioVC = PortfolioViewController()
        portfolioVC.tabBarItem = UITabBarItem(title: "Portfolio", image: #imageLiteral(resourceName: "portfolio-tabbar"), tag: 0)
//        portfolioVC.tabBarItem.selectedImage = UIImage(named: "portfolio-tabbar-selected")
        

        let tabBarController = BubbleTabBarController()
        tabBarController.viewControllers = [homeVC, fearIndexVC, portfolioVC]
        tabBarController.tabBar.tintColor = #colorLiteral(red: 0.1579992771, green: 0.1818160117, blue: 0.5072338581, alpha: 1)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.pushViewController(tabBarController, animated: true)
    }
    


}

