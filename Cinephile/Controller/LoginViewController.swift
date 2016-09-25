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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Action
    
    @IBAction func LoginAction(_ sender: AnyObject) {
        Auth2Api.sharedInstance.authorizeUser()
    }

    @IBAction func logoutAction(_ sender: AnyObject) {
        APIClient.sharedInstance.logout()
    }
    
    @IBAction func getUserInfoAction(_ sender: AnyObject) {
        APIClient.sharedInstance.getUserDetails()
    }
}
