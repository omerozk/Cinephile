//
//  Auth2Api.swift
//  Cinephile
//
//  Created by omer ozkul on 24/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation
import p2_OAuth2
import Alamofire

class Auth2Api {
    
    static let sharedInstance: Auth2Api = {
        let singleton = Auth2Api()
        return singleton
    }()
    
    var loader: OAuth2DataLoader?
    
    init() {
    }
    
    let oauth2Instance: OAuth2CodeGrant = {
        let oauth2 = OAuth2CodeGrant(settings: [
            "client_id": traktApiClientId,
            "client_secret": traktApiSecret,
            "authorize_uri": baseUrl + kOAuthAuthroizeUrlKey,
            "token_uri": baseUrl + kOAuthTokenUrlKey,   // code grant only
            "response_type": "code",
            "redirect_uris": ["cinephile://authorize"],   // register your own "myapp" scheme in Info.plist
            "keychain": true,         // keychain integration
            ] as OAuth2JSON)
        
        // display login screen in app not on safari
//        oauth2.authConfig.authorizeEmbedded = true
//        oauth2.authConfig.authorizeContext = UIApplication.shared.delegate?.window!?.rootViewController!

        // debug log
        oauth2.logger = OAuth2DebugLogger(.trace)
        
        return oauth2
    }()
    
    func getAccessToken() -> String? {
        return Auth2Api.sharedInstance.oauth2Instance.accessToken
    }
    
    func cleanOAuth2Data() {
        // delete credential from keychain
        self.oauth2Instance.forgetTokens()
    
        // delete cookies to reload login page from Safari
        let storage = HTTPCookieStorage.shared
        storage.cookies?.forEach() { storage.deleteCookie($0) }
    }

    
    func authorizeUser() -> Void {
        let oauth2 = self.oauth2Instance

        oauth2.authorize { (response, error) in
            let sessionManager = APIClient.sharedInstance
            let retrier = OAuth2RetryHandler(oauth2: oauth2)
            sessionManager.adapter = retrier
            sessionManager.retrier = retrier
            
            sessionManager.getUserDetails()
        }
    }
    
}

// Manage refresh token and access_token in header
class OAuth2RetryHandler: RequestRetrier, RequestAdapter {
    
    let loader: OAuth2DataLoader
    
    init(oauth2: OAuth2) {
        loader = OAuth2DataLoader(oauth2: oauth2)
    }
    
    /// Intercept 401 and do an OAuth2 authorization.
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse, 401 == response.statusCode, let req = request.request {
            var dataRequest = OAuth2DataRequest(request: req, callback: { _ in })
            dataRequest.context = completion
            loader.enqueue(request: dataRequest)
            loader.attemptToAuthorize() { authParams, error in
                self.loader.dequeueAndApply() { req in
                    if let comp = req.context as? RequestRetryCompletion {
                        comp(nil != authParams, 0.0)
                    }
                }
            }
        }
        else {
            completion(false, 0.0)   // not a 401, not our problem
        }
    }
    
    /// Sign the request with the access token.
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        guard nil != loader.oauth2.accessToken else {
            return urlRequest
        }
        return urlRequest.signed(with: loader.oauth2)
    }
}
