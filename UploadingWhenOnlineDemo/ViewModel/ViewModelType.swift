//
//  ViewModelType.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
