//
//  APIClient+movies.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

extension APIClient {
    
    @discardableResult func getWeekBoxOfficeMovies(successBlock: ((_ movies: [Movie]) -> Void)? = nil,
                                                   failureBlock: ((_ error: NSError) -> Void)? = nil) -> Alamofire.Request? {
        return doRequest(method: .get, urlPath: kBoxOfficeMoviesUrlKey, parameters: nil, successBlock: { (jsonResponse) in
            var movies: [Movie] = []
            
            for (_, movieDict):(String, JSON) in jsonResponse {
                movies.append(Movie(json: movieDict["movie"]))
            }
            
            successBlock?(movies)
            }, failureBlock: { (error) in
                failureBlock?(error)
        })
    }
}
