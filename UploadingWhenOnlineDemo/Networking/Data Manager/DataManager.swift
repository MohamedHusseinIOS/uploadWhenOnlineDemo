//
//  DataManager.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

class DataManager {

    static let shared = DataManager()
    
    let reachapiltyManager = NetworkReachabilityManager(host: "www.google.com")
    let bag = DisposeBag()
    
    private init(){}
    
    private func handelResponseData<T: BaseModel>( response: ResponseEnum, model: T.Type) -> ResponseEnum {
        switch response {
        case .success(let value):
            guard let value = value else { return  .failure(ApiError.ClientSideError, nil)}
            let responseData = model.decodeJSON(value, To: model, format: .convertFromSnakeCase)
            return .success( responseData )
        case .failure(let error, let data):
            return .failure(error, data)
        }
    }
    
     func uploadImage(images: Array<ImageModel>) -> Observable<Any> {
        let observable = Observable<Any>.create { (observer) -> Disposable in
            let group = DispatchGroup()
            var groupResponse = Array<UploadResponse>()
            images.forEach { (image) in
                group.enter()
                guard let base64Str = image.imageData?.base64EncodedString(options: .lineLength64Characters) else { return }
                let params = ["image": base64Str] as [String: Any]
                NetworkManager.shared.post(url: URLs.Image.URL, paramters: params) { (response) in
                    let resEnum = self.handelResponseData(response: response, model: UploadResponse.self)
                    switch resEnum {
                    case .success(let value):
                        guard let res = value as? UploadResponse else { return }
                        groupResponse.append(res)
                    case .failure(let err, _):
                        guard let error = err else {
                            observer.onCompleted()
                            return
                        }
                        observer.onNext(error)
                        observer.onCompleted()
                    }
                    group.leave()
                }
            }
            group.notify(queue: .global()) {
                observer.onNext(groupResponse)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        return observable
    }
    
    func getImages(ids: Array<String>) -> Observable<Any> {
        let observable = Observable<Any>.create { (observer) -> Disposable in
            let group = DispatchGroup()
            var imagesResponse = Array<Any>()
            ids.forEach { (id) in
                group.enter()
                let url = URLs.Image.URL + "/\(id)"
                NetworkManager.shared.get(url: url) { (response) in
                    let resEnum = self.handelResponseData(response: response, model: UploadResponse.self)
                    switch resEnum {
                    case .success(let value):
                        guard let res = value as? UploadResponse else { return }
                        imagesResponse.append(res)
                    case .failure(let err, _):
                        guard let error = err else {
                            observer.onCompleted()
                            return
                        }
                        observer.onNext(error)
                        observer.onCompleted()
                    }
                    group.leave()
                }
            }
            group.notify(queue: .global()) {
                observer.onNext(imagesResponse)
                observer.onCompleted()
            }
            return Disposables.create()
        }
        
        return observable
    }
}
