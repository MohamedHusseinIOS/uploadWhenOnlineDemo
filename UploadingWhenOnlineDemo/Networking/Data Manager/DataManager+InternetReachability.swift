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
    
    func uploadImages(imagesArray: Array<ImageModel>) {
        reachapiltyManager?.startListening(onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .reachable(_):
                self.upload(images: imagesArray)
            case .notReachable:
                break
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
}
