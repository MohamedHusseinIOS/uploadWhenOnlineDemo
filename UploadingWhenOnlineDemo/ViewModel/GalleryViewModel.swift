//
//  GalleryViewModel.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


class GalleryViewModel: BaseViewModel, ViewModelType{
    
    struct Input {}
    
    struct Output {
        let imagesData: Observable<[Data]>
    }
    
    let input: GalleryViewModel.Input
    let output: GalleryViewModel.Output
    
    private let imagesDataSubj = PublishSubject<[Data]>()
    private let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")
    
    override init() {
        input = Input()
        output = Output(imagesData: imagesDataSubj.asObservable())
        super.init()
    }
    
    
    
}
