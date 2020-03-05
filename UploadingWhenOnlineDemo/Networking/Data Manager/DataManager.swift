//
//  DataManager.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import RxSwift

class DataManager {
    
    static let shared = DataManager()
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
            var groupResponse = Array<Any>()
            images.forEach { (image) in
                group.enter()
                guard let base64Str = image.imageData?.base64EncodedString(options: .lineLength64Characters) else { return }
                let params = ["image": base64Str] as [String: Any]
                NetworkManager.shared.post(url: URLs.UploadImage.URL, paramters: params) { (response) in
                    let resEnum = self.handelResponseData(response: response, model: UploadResponse.self)
                    switch resEnum {
                    case .success(let value):
                        guard let res = value else { return }
                        groupResponse.append(res)
                    case .failure(let err, let data):
                        break
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
}
