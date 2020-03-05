//
//  UploadResponse.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation

struct UploadResponse: BaseModel {
    let data: DataClass?
    let status, success: Int?
}

// MARK: - DataClass
struct DataClass: BaseModel {
    let accountID: Int?
    let accountURL: String?
    let adType: Int?
    let adURL: String?
    let animated, bandwidth: Int?
    let datetime, deletehash, dataDescription: String?
    let edited, favorite, hasSound, height: Int?
    let id: String?
    let inGallery, inMostViral, isAd: Int?
    let link: String?
    let name, nsfw, section: String?
    let size: Int?
    let tags: [String]?
    let title, type: String?
    let views: Int?
    let vote: String?
    let width: Int?
}
