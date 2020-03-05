//
//  ErrorModel.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation

struct ErrorModel: BaseModel{
    
    var name: String?
    var field: String?
    var message: String?
    var status: Int?
    var code: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
        case field
        case message
        case status
        case code
    }
}
