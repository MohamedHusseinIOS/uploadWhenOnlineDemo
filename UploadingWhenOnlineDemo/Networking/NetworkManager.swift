//
//  NetworkManager.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import Alamofire

enum ResponseEnum {
    case failure(_ error: ApiError?, _ data: Any?)
    case success(_ value: Any?)
}

enum ApiError: Int {
    case BadRequest = 400
    case DataValidationFailed = 422
    case ServerError = 500
    case ClientSideError = 0
    
    var message: String{
        switch self {
        case .BadRequest:
            return "Bad request"
        case .ServerError:
            return "Internal Server Error"
        case .ClientSideError:
            return "ClientSide Error"
        case .DataValidationFailed:
            return "Data Validation Failed"
        }
    }
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init(){}
    typealias responseCallback = ((ResponseEnum) -> Void)
    
    private var headers: HTTPHeaders {
        let headerDict = [
                            "Content-Type":"application/json",
                            "Authorization":"Client-ID cd46b63d6f0be95"
                        ]
        return HTTPHeaders(headerDict)
    }
    
    
    func get(url: String, paramters: Parameters? = nil, completion: @escaping responseCallback){
        
        AF.request(url, method: .get, parameters: paramters, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            response.interceptResuest(url, paramters)
            self.handleResponse(response, completion: completion)
        }
    }
    
    func post(url: String, paramters: Parameters?, completion: @escaping responseCallback){
        
        AF.request(url, method: .post, parameters: paramters, encoding: JSONEncoding.default, headers: headers).responseJSON { (response) in
            response.interceptResuest(url, paramters)
            DispatchQueue.main.async {
                 self.handleResponse(response, completion: completion)
            }
        }
    }
    
    private func handleResponse(_ response: AFDataResponse<Any>, completion: @escaping responseCallback) {
        guard let code = response.response?.statusCode else {
            completion(.failure(ApiError.ClientSideError, nil))
            return
        }
        if code < 400, let res = response.value as? Parameters {
            completion(.success(res))
        } else if let res = response.value {
            self.errorHandling(res, code: code, completion: completion)
        }
    }
    
    func errorHandling(_ res: Any, code: Int,completion: @escaping responseCallback){
        let error = ApiError(rawValue: code)
        let errorModel = ErrorModel.decodeJSON(res, To: ErrorModel.self, format: .convertFromSnakeCase)
        completion(.failure(error, errorModel))
    }
}
