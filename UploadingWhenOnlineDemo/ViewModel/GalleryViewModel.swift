//
//  GalleryViewModel.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation


class GalleryViewModel: BaseViewModel, ViewModelType{
    
    struct Input {}
    
    struct Output {}
    
    let input: GalleryViewModel.Input
    let output: GalleryViewModel.Output
    
    override init() {
        input = Input()
        output = Output()
        super.init()
        
    }
}
