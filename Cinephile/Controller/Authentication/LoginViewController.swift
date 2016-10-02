//
//  LoginViewController.swift
//  Cinephile
//
//  Created by omer ozkul on 25/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func LoginAction(_ sender: AnyObject) {
        APIClient.sharedInstance.authorizeUser(successBlock: { () in
            self.navigationController?.pushViewController(R.storyboard.rootTabBar.rootTabBarVC()!, animated: true)
            }) { (error) in
                // Display alert
        }
    }
}
