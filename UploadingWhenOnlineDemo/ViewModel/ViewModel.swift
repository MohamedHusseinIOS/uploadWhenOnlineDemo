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
        DataManager.shared.uploadImages(imagesArray: imagesArray)
    }
    
//    func storeImage(image: UIImage, forKey key: String) {
//        let fileManager = FileManager.default
//        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
//        let imageUrl = url.appendingPathComponent(key + ".png")
//        let imagePngData = image.pngData()
//        do{
//            try imagePngData?.write(to: imageUrl)
//        } catch let err {
//            print(err)
//        }
//    }
    
}
