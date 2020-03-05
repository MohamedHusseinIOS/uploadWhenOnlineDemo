//
//  URLs.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation

enum URLs: String {
    
    case Image = "image"
    
    var mainURL: String {
      return "https://api.imgur.com/3/"
    }
    
    var URL: String {
        return self.mainURL + self.rawValue
    }
}
