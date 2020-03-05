//
//  ViewModel.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

class ViewModel: BaseViewModel, ViewModelType {

    struct Input {}
    
    struct Output {}
    
    let input: ViewModel.Input
    let output: ViewModel.Output
    
    private let reachapiltyManager = NetworkReachabilityManager(host: "www.google.com")
    private var imagesArray = Array<ImageModel>()
    
    override init() {
        input = Input()
        output = Output()
        super.init()
        guard let array = UserDefaults.standard.value(forKey: Constants.imagesArray.rawValue) as? Array<ImageModel> else { return }
        imagesArray = array
    }
    
    func saveImage(image: UIImage?, forKey key: String){
        let imageModel = ImageModel(imageURL: nil, imageName: key, imageData: image?.jpegData(compressionQuality: 0.2))
        imagesArray.append(imageModel)
        setStructArray(imagesArray, forKey: Constants.imagesArray.rawValue)
        reachapiltyManagerStartLisiten()
    }
    
    func storeImage(image: UIImage, forKey key: String) {
        let fileManager = FileManager.default
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let imageUrl = url.appendingPathComponent(key + ".png")
        let imagePngData = image.pngData()
        do{
            try imagePngData?.write(to: imageUrl)
        } catch let err {
            print(err)
        }
    }
    
    private func reachapiltyManagerStartLisiten() {
        reachapiltyManager?.startListening(onUpdatePerforming: { [unowned self] (status) in
            switch status {
            case .reachable(_):
                self.uploadImages(images: self.imagesArray)
            case .notReachable:
                break
            case .unknown:
                break
           
            }
        })
    }
    
    private func uploadImages(images: Array<ImageModel>){
        reachapiltyManager?.stopListening()
        DataManager.shared.uploadImage(images: images).subscribe { (event) in
            guard let element = event.element else { return }
            
        }.disposed(by: bag)
    }
    
    
    
    func resetImagesArray(){
        self.imagesArray.removeAll()
        UserDefaults.standard.removeObject(forKey: Constants.imagesArray.rawValue)
        UserDefaults.standard.synchronize()
    }
    
}
