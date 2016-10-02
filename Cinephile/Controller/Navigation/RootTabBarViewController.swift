//
//  RootTabBarViewController.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.viewControllers = createTabBarItems()
        tabBar.barTintColor = UIColor.white
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.appRedColor()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createTabBarItems() -> [UIViewController] {
        let movies = UINavigationController(rootViewController: R.storyboard.movies.moviesVC()!)
        let account = UINavigationController(rootViewController: R.storyboard.account.accountVC()!)

        // title shoud be set before view did load, after createTabBarItem, or the tab bar won't show the title correctly.
        movies.viewControllers[0].title = "Movies"
        account.viewControllers[0].title = "Account"
        
        movies.tabBarItem = createTabBarItem(image: R.image.menuMovies(), selectedImage: R.image.menuMovies()?.withRenderingMode(.alwaysOriginal))
        account.tabBarItem = createTabBarItem(image: R.image.menuAccount(), selectedImage: R.image.menuAccount()?.withRenderingMode(.alwaysOriginal))
        
        // array of the root view controllers displayed by the tab bar interfacei
        return [movies, account]
    }
    
    func createTabBarItem(image: UIImage?, selectedImage: UIImage?) -> UITabBarItem {
        let tabBarItem = UITabBarItem(title: "", image: image, selectedImage: selectedImage)
        
        return tabBarItem
    }

}
