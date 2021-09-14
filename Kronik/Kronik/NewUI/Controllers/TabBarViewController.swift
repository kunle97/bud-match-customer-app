//
//  ViewController.swift
//  BudMatch
//
//  Created by Kunle Ademefun on 9/2/20.
//

import UIKit
import FloatingPanel

class TabBarViewController: UITabBarController, FloatingPanelControllerDelegate {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        tabBar.barTintColor = .white
        tabBar.itemWidth = view.frame.size.width/5
        setupTabBar()
    }

    func setupTabBar(){
        let homeController = createNavController(vc: HomeViewController(), selectedImage: #imageLiteral(resourceName: "leaf1-green-ui"), unselectedImage: #imageLiteral(resourceName: "home-icon-unselected"))
        let searchController = createNavController(vc: SearchViewController(), selectedImage: #imageLiteral(resourceName: "search-icon-selected"), unselectedImage: #imageLiteral(resourceName: "search-icon-unselected"))
//        let jarController = createNavController(vc: MyJarViewController(), selectedImage: #imageLiteral(resourceName: "jar-icon-selected"), unselectedImage: #imageLiteral(resourceName: "jar-icon-unselected"))
//        let ordersController = createNavController(vc: OrdersViewController(), selectedImage: #imageLiteral(resourceName: "orders-icon-selected"), unselectedImage: #imageLiteral(resourceName: "orders-icon"))
//        let accountController = createNavController(vc: MyAccountViewController(), selectedImage: #imageLiteral(resourceName: "account-icon-selected"), unselectedImage: #imageLiteral(resourceName: "account-icon-unselected"))
//
       viewControllers = [
        homeController,
//        searchController,
//        jarController,
//        ordersController,
//        accountController
       ]
        
        guard let items = tabBar.items  else {
            return
        }
        for item in items{
            item.imageInsets = UIEdgeInsets(top: 15,left: 0,bottom: -15,right: 0)
        }
    }


}






extension UITabBarController{
    func createNavController(vc: UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController{
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image =  unselectedImage
        navController.tabBarItem.selectedImage =  selectedImage
        return navController
    }
}

//MARK: - FOR REFERENCE
