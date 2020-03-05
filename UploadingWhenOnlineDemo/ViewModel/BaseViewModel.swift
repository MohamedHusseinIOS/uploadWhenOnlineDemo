//
//  BaseViewModel.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/3/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import Foundation
import RxSwift

class BaseViewModel {
    
    var bag = DisposeBag()
    
    init() {}
    
    func handelApiError(data: Any?, failer: PublishSubject<[ErrorModel]>){
        if let err = data as? ErrorModel{
            failer.onNext([err])
        }else if let errorArr = data as? [ErrorModel]{
            failer.onNext(errorArr)
        }
    }
}
