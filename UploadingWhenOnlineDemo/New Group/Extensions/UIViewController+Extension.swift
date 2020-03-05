//
//  UIViewController+Extension.swift
//  etajerIOS
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String, completion: (()->Void)?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            completion?()
        }
        
        alert.addAction(action)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func alertWithCancel(title: String, message: String, actionTitle: String, completion: ((Bool)->Void)?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "CANCEL", style: .cancel) { (_) in
            completion?(false)
        }
        
        let action = UIAlertAction(title: actionTitle, style: .default) { (_) in
            completion?(true)
        }
        
        alert.addAction(cancel)
        alert.addAction(action)
        navigationController?.present(alert, animated: true, completion: nil)
    }
}
