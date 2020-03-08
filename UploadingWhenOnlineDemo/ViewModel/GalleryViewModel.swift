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
        let imagesData: Observable<[Any]>
    }
    
    let input: GalleryViewModel.Input
    let output: GalleryViewModel.Output
    
    private let imagesDataSubj = PublishSubject<[Any]>()
    
    override init() {
        input = Input()
        output = Output(imagesData: imagesDataSubj.asObservable())
        super.init()
    }
    
    func getGalleryImages(){
        DataManager.shared.getGallery().subscribe { (event) in
            if let imagesArr = event.element as? [UploadResponse] {
                let imagesLinksArr = imagesArr.compactMap({$0.data?.link})
                self.imagesDataSubj.onNext(imagesLinksArr)
            } else if let imagesDataArr = event.element as? [Data] {
                self.imagesDataSubj.onNext(imagesDataArr)
            }
        }.disposed(by: bag)
    }
    
}
