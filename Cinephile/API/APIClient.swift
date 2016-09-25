//
//  APIClient.swift
//  Cinephile
//
//  Created by omer ozkul on 24/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIClient: SessionManager {
    static var sharedInstance: APIClient = {
        let apiClient = APIClient()

        return apiClient
    }()

    @discardableResult func doRequest(method: HTTPMethod, urlPath: String,  parameters: [String : AnyObject]? = nil, successBlock: @escaping (Any) -> Void, failureBlock: @escaping (NSError) -> Void) -> Alamofire.Request? {
        let encoding: ParameterEncoding = JSONEncoding.default
        let header = getDefaultHeader()
        
        let request = self.request(baseUrl + urlPath, method: method, parameters: parameters, encoding: encoding, headers: header)

        request.responseJSON { (response) in
            // sometimes, server returns nothing when the response success.
            if let data = response.data, let statusCode = response.response?.statusCode, data.count == 0 && statusCode < 400 {
                dlog(message: "\(urlPath) Success without response")
                successBlock(jsonResponse: JSON(""))
                return
            }
            switch response.result {
            case .success(let successValue):
                dlog(message: "\(urlPath) SuccessValue : \(successValue)")
                guard let statusCode = response.response?.statusCode else {
                    failureBlock(NSError())
                    return
                }

                guard statusCode >= 400 else {
                    dlog(message: "\(urlPath) Success with \(statusCode)")
                    successBlock(jsonResponse: JSON(data: response.data!))
                    return
                }

                guard statusCode == 401 else {
                    dlog(message: "\(urlPath) Failure In success block (old API): \(statusCode) \(JSON(data: response.data!))")
                    failureBlock(NSError())
                    return
                }

                // manage refresh token when expired
                dlog(message: "\(urlPath) Failure In success because token expired: \(statusCode) \(JSON(data: response.data!))")
                self.retrier?.should(self, retry: request, with: NSError(), completion: { (shouldRetry, time) in
                    if (shouldRetry) {
                        self.doRequest(method: method, urlPath: baseUrl + urlPath, parameters: parameters, successBlock: successBlock, failureBlock: failureBlock)
                    } else {
                        failureBlock(NSError())
                    }
                })
                
            case .failure(let error):
                dlog(message: "\(urlPath) Failure \(request)")
                guard let statusCode = response.response?.statusCode else {
                    failureBlock(NSError())
                    dlog(message: "\(response)")
                    return
                }

                guard statusCode == 401 else {
                    // success
                    if (statusCode < 400) {
                        dlog(message: "\(urlPath) Success in failure block because no data returned \(statusCode)")
                        successBlock(jsonResponse: JSON(nilLiteral: ()))
                        return
                    }
                    
                    // error
                    failureBlock(NSError())
                    return
                }
                
                dlog(message: "\(urlPath) Failure accessToken expired \(statusCode)")
                // manage refresh token when expired
                self.retrier?.should(self, retry: request, with: error, completion: { (shouldRetry, time) in
                    if (shouldRetry) {
                        self.doRequest(method: method, urlPath: baseUrl + urlPath, parameters: parameters, successBlock: successBlock, failureBlock: failureBlock)
                    } else {
                        failureBlock(NSError())
                    }
                })
            }
        }
        return request
    }
    
    private func getDefaultHeader() -> [String: String] {
        var header = [String: String]()
        header["Content-Type"] = "application/json"
        header["trakt-api-version"] = "2"
        header["trakt-api-key"] = traktApiClientId
        return header
    }
}
