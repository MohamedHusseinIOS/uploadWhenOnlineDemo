//
//  Constants.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import UIKit

enum Constants: String{
    case AppleLanguages
    case imagesArray
    case imageCounter
    case imagesIds
    case uploadPhotos = "com.demo.uploadPhotos"
}

enum AppLanguages: String{
    case en, ar
}

enum Colors{
    case Rose
    case PrimaryColor
    
    var value: UIColor{
        switch  self {
        case .Rose:
            return UIColor(red: 235/255, green: 85/255, blue: 91/255, alpha: 1)
        case .PrimaryColor:
            return #colorLiteral(red: 0.2761612535, green: 0.1481507123, blue: 0.3897372484, alpha: 1)
        }
        
    }
}
