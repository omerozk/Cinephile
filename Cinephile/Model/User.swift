//
//  User.swift
//  Cinephile
//
//  Created by omer ozkul on 25/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    var userId: String
    var username: String
    var name: String

    init(json: JSON) {
        userId = json["id"].string ?? ""
        username = json["username"].string ?? ""
        name = json["name"].string ?? ""
    }
}
