//
//  APIClient+User.swift
//  Cinephile
//
//  Created by omer ozkul on 25/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {

    func authorizeUser(successBlock: ((Void) -> Void)? = nil,
                       failureBlock: ((_ error: NSError) -> Void)? = nil) -> Void {
        Auth2Api.sharedInstance.authorizeUser(successBlock: successBlock, failureBlock: failureBlock)
    }
    
    @discardableResult func getUserDetails(successBlock: ((_ user: User) -> Void)? = nil,
                                           failureBlock: ((_ error: NSError) -> Void)? = nil) -> Alamofire.Request? {
        return doRequest(method: .get, urlPath: kUserInfoUrlKey, successBlock: { (jsonResponse) in
            
            // update user if exist
            UserManager.sharedInstance.user = User(json: jsonResponse)
            successBlock?(UserManager.sharedInstance.user!)
            
            }, failureBlock: { (error) in
                failureBlock?(error)
        })
    }
    
    @discardableResult func logout(successBlock: (() -> Void)? = nil,
                                   failureBlock: ((_ error: NSError) -> Void)? = nil) -> Alamofire.Request? {
        var params = Dictionary<String, AnyObject>()
        params["token"] = Auth2Api.sharedInstance.getAccessToken() as AnyObject?
        
        dlog(message: "\(params)")
        let request: Alamofire.Request? = doRequest(method: .post, urlPath: kOAuthRevokeTokenUrlKey, parameters: params, successBlock: { (jsonResponse) in
            successBlock?()
            }, failureBlock: { (error) in
                failureBlock?(error)
        })
        Auth2Api.sharedInstance.cleanOAuth2Data()
        UserManager.sharedInstance.cleanUserData()

        // go back to root controller which is login screen
        AppDelegate.backToLoginVC()

        return request
    }

    
}
