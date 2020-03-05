//
//  ImageModel.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation

struct ImageModel: BaseModel {
    let imageURL: URL?
    let imageName: String?
    let imageData: Data?
}
