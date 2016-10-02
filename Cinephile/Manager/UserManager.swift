//
//  UserManager.swift
//  Cinephile
//
//  Created by omer ozkul on 25/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit

class UserManager: NSObject {
    static var sharedInstance: UserManager = {
        let userManager = UserManager()
        return userManager
    }()

    var isLoggedIn: Bool {
        
        if let token = Auth2Api.sharedInstance.getAccessToken() {
            if token.isEmpty == false {
                return true
            }
        }
        return false
    }
    
    var user : User?
    
    override init() {
        user = nil
    }

    func cleanUserData() {
        user = nil
    }
    
}
