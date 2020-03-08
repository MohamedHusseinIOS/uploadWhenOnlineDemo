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
    let status: Int?
    let success: Bool?
}

// MARK: - DataClass
struct DataClass: BaseModel {
    let accountID: Int?
    let accountURL: String?
    let adType: Int?
    let adURL: String?
    let animated: Bool?
    let bandwidth: Double?
    let datetime: Int?
    let deletehash, dataDescription: String?
    let edited: String?
    let favorite: Bool?
    let hasSound: Bool?
    let height: Double?
    let id: String?
    let inGallery, inMostViral, isAd: Bool?
    let link: String?
    let name, section: String?
    let size: Int?
    let tags: [String]?
    let title, type: String?
    let views: Int?
    let vote: String?
    let width: Double?
}
