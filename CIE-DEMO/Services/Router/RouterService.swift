//
//  RouterService.swift
//  CIE-DEMO
//
//  Created by hassan uriostegui on 9/21/19.
//  Copyright © 2019 eonflux. All rights reserved.
//

import UIKit
import DTPhotoViewerController

class RouterService: NSObject {
    
    var window : UIWindow!
    var tabController : UITabBarController!
    var homeNavController: UINavigationController!
    var favoritesNavController : UINavigationController!
    var homeRootController : HomeViewController!
    var favoritesRootController : FavoritesViewController!
    
    public func setup(withWindow aWindow:UIWindow){
        
        assert(window == nil, "This instance is already setup")
        window = aWindow
        
        styleApp()
        initTab()
        
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        
    }
    
    public func styleApp(){
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        // Sets shadow (line below the bar) to a blank image
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .black
    }
    
    public func initTab(){
        
        tabController = UITabBarController()
        tabController.tabBar.tintColor = .black
        
        homeRootController =  HomeViewController()
        favoritesRootController = FavoritesViewController()
        
        homeRootController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        favoritesRootController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        homeNavController = UINavigationController(rootViewController:homeRootController )
        favoritesNavController = UINavigationController(rootViewController: favoritesRootController)
        
        homeNavController.navigationBar.prefersLargeTitles = true
        favoritesNavController.navigationBar.prefersLargeTitles = true
        
        tabController.viewControllers = [homeNavController,
                                         favoritesNavController]
        
    }

}

extension RouterService {
    
    func activeNavigationController()->UINavigationController?{
     
        if let nav = tabController.selectedViewController {
            
            if nav.isKind(of: UINavigationController.self){
                return nav as? UINavigationController
            }
            
            return nav.navigationController
        }
        
        return nil
    }
}

extension RouterService {
    func pushDetailViewController(movie : Movie){

        if let navController = activeNavigationController() {
        
            let detail = DetailViewController()
            detail.setupWith(movie: movie)
           
            navController.pushViewController(detail, animated: true)
            
            
        }
    }
    
    func presentImageViewPreview(_ imageView: UIImageView){
        
        guard let topController = UIApplication.shared.keyWindow?.rootViewController else {
            return
        }
        
        let viewController = DTPhotoViewerController(referencedView: imageView, image: imageView.image)
        topController.present(viewController, animated: true, completion: nil)
    }
}
