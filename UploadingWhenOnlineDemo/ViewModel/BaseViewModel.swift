//
//  BaseViewModel.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    var bag = DisposeBag()
    
    init() {}
    
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
    
    func handelApiError(data: Any?, failer: PublishSubject<[ErrorModel]>){
        if let err = data as? ErrorModel{
            failer.onNext([err])
        }else if let errorArr = data as? [ErrorModel]{
            failer.onNext(errorArr)
        }
    }
}
