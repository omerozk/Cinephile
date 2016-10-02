//
//  MediaImageMultiSize.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import SwiftyJSON

class MediaImageMultiSize: NSObject {
    var full: String
    var medium: String
    var thumb: String
    
    init(json: JSON) {
        full = json["full"].string ?? ""
        medium = json["medium"].string ?? ""
        thumb = json["thumb"].string ?? ""
    }

}
