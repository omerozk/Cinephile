//
//  MediaImages.swift
//  Cinephile
//
//  Created by omer ozkul on 02/10/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import UIKit
import SwiftyJSON

class MediaImages: NSObject {
    var fanart: MediaImageMultiSize
    var poster: MediaImageMultiSize
    var logo: String
    var clearart: String
    var banner: String
    var thumb: String
    
    init(json: JSON) {
        fanart = MediaImageMultiSize(json: json["fanart"])
        poster = MediaImageMultiSize(json: json["poster"])
        logo = json["logo"]["full"].string ?? ""
        clearart = json["clearart"]["full"].string ?? ""
        banner = json["banner"]["full"].string ?? ""
        thumb = json["thumb"]["full"].string ?? ""
    }

}
