//
//  MovieIds.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieIds: NSObject {
    var traktId: String
    var slug: String
    var imdb: String
    var tmdb: String
    
    init(json: JSON) {
        traktId = json["trakt"].string ?? ""
        slug = json["slug"].string ?? ""
        imdb = json["imdb"].string ?? ""
        tmdb = json["tmdb"].string ?? ""
    }
}
