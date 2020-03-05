//
//  internetReachability.swift
//  UploadingWhenOnlineDemo
//
//  Created by Admin on 3/5/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift

extension DataManager {
    
    func getGallery() -> Observable<Any> {
        if (self.reachapiltyManager?.isReachable ?? false), let ids = UserDefaults.standard.array(forKey: Constants.imagesIds.rawValue) as? [String] {
            return getImages(ids: ids)
        } else {
            return getImagesArray()
        }
    }
    
    private func getImagesArray() -> Observable<Any> {
        let images = self.getStructArrayData(ImageModel.self, forKey: Constants.imagesArray.rawValue)
        let imagesData = images.compactMap({$0.imageData})
        return Observable<Any>.create { (observer) -> Disposable in
            observer.onNext(imagesData)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func uploadImages(imagesArray: Array<ImageModel>) {
        reachapiltyManager?.startListening(onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .reachable(_):
                self.upload(images: imagesArray)
            case .notReachable:
                self.setStructArray(imagesArray, forKey: Constants.imagesArray.rawValue)
            case .unknown:
                break
            }
        })
    }
    
    private func upload(images: Array<ImageModel>){
        reachapiltyManager?.stopListening()
        self.uploadImage(images: images).subscribe { [unowned self] (event) in
            guard let responseArr = event.element as? [UploadResponse] else { return }
            let ids = responseArr.compactMap({$0.data?.id})
            self.saveIdsInUserDefualts(ids: ids)
            self.resetImagesArray()
        }.disposed(by: bag)
    }
    
    private func saveIdsInUserDefualts(ids: Array<String>){
        var imagesIds = Array<String>()
        if let ids = UserDefaults.standard.array(forKey: Constants.imagesIds.rawValue) as? [String] {
            imagesIds.append(contentsOf: ids)
        }
        imagesIds.append(contentsOf: ids)
        UserDefaults.standard.set(imagesIds, forKey: Constants.imagesIds.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    private func resetImagesArray(){
        UserDefaults.standard.removeObject(forKey: Constants.imagesArray.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func saveOnUserDefuslts<T: BaseModel>(value: T, forKey key: String){
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.setValue(encoded, forKeyPath: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    func getFromUserDefualts<T: BaseModel>(byKey key: String, model: T.Type) -> T? {
        if let value = UserDefaults.standard.object(forKey: key) as? Data {
            let decoder = JSONDecoder()
            if let loadedModel = try? decoder.decode(model.self, from: value){
                return loadedModel
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func setStructArray<T: BaseModel>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: defaultName)
        UserDefaults.standard.synchronize()
    }
    
    func getStructArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = UserDefaults.standard.array(forKey: defaultName) as? [Data] else { return [] }
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
}
