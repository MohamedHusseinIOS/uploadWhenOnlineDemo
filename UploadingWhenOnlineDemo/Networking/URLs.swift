//
//  URLs.swift
//  etajerIOS
//
//  Created by mohamed on 7/29/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import Foundation

enum URLs: String {
    
    case login                      = "/api/v1/user/login"
    case signup                     = "/api/v1/user/signup"
    case requestResetPassword       = "/api/v1/user/request-reset-password"
    case currentUser                = "/api/v1/user/current"
    case logout                     = "/api/v1/user/logout"
    
    case products                   = "/api/v1/products"
    case productDetails             = "/api/v1/products/details?"
    case categories                 = "/api/v1/products/categories"
    case homePage                   = "/api/v1/products/homepage"
    
    case getCart                    = "/api/v1/order/cart?hash=111"
    case addToCart                  = "/api/v1/order/add-to-cart?hash=111"
    case removeFormCart             = "/api/v1/order/remove-from-cart?hash=111"
    
    case getAddresses               = "/api/v1/user/addresses"
    case newAddress                 = "/api/v1/user/new-address"
    
    case getMyOrders                = "/api/v1/my-orders/index"
    case getOrderDetails            = "/api/v1/my-orders/details"
    case getNotifications           = "/api/v1/notifications/index"
    case getFavoritesProduct        = "/api/v1/fav/index"
    case getFavoritesStores         = "/api/v1/fav/stores"
    case changeUserData             = "/api/v1/user/change-data"
    case changePassword             = "/api/v1/user/change-password"
    case chnageBankInfo             = "/api/v1/user/bank-info"
    
    
    var URL: String{
        return AppUtility.shared.currentEnviroment + self.rawValue
    }
}
