//
//  Utils.swift
//  Cinephile
//
//  Created by omer ozkul on 25/09/16.
//  Copyright © 2016 Omerozk. All rights reserved.
//

import Foundation

func dlog(message: String, filename: String = #file, function: String = #function, line: Int = #line) {
    
    #if !RELEASE
        let filenameNSString = filename as NSString
        
        print("[\(filenameNSString.lastPathComponent):\(line)] \(function): \(message)")
    #endif
    
}

func getUserLanguage() -> String {
    let fullString = Locale.preferredLanguages[0]
    
    let languageAndRegion: [String] = fullString.components(separatedBy: "-")
    
    if (languageAndRegion.count > 1) {
        return languageAndRegion[0]
    }
    
    return fullString
}
