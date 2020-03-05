//
//  DataResponse+Extension.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import Alamofire

extension DataResponse {
    
    func interceptResuest(_ url: String, _ params: Parameters?){
    
        print("================(\(url))============== \n")
        print("parameters =======> \(params ?? [:]) \n")
        print("Header =====> \(request?.allHTTPHeaderFields ?? [:]) \n")
        print(response?.url?.absoluteURL ?? "")
        print("statusCode =====> \(response?.statusCode ?? 00000) \n")
        print("result ======> ", (try? result.get()) ?? "")
    }
}
