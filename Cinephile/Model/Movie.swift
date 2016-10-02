//
//  Movie.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import SwiftyJSON

class Movie: NSObject {
    var title: String
    var year: String
    var ids: MovieIds
    var images: MediaImages
    
    init(json: JSON) {
        title = json["title"].string ?? ""
        year = json["year"].string ?? ""
        ids = MovieIds(json: json["ids"])
        images = MediaImages(json: json["images"])
    }
}
