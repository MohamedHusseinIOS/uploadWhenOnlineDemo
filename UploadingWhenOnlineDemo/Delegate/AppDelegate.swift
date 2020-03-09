//
//  AppDelegate.swift
//  UploadingWhenOnlineDemo
//
//  Created by mohamed hussein on 3/4/20.
//  Copyright © 2020 Mohamed Hussein. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire
import BackgroundTasks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constants.uploadPhotos.rawValue, using: .global()) { (task) in
            DataManager.shared.reachapiltyManager?.startListening(onUpdatePerforming: { (status) in
                switch status {
                    case .reachable(_):
                        self.handleAppRefreshTask(task: task)
                    case .notReachable:
                        print("internet is not reachable")
                    case .unknown:
                        break
                }
            })
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    private func handleAppRefreshTask(task: BGTask) {
        task.expirationHandler = {
            AF.cancelAllRequests()
        }
        
        guard let imagesArr = UserDefaults.standard.array(forKey: Constants.imagesArray.rawValue) as? [ImageModel] else { return }
        DataManager.shared.uploadImage(images: imagesArr).subscribe { (event) in
            guard let responseArr = event.element as? [UploadResponse] else { return }
            let ids = responseArr.compactMap({$0.data?.id})
            DataManager.shared.saveIdsInUserDefualts(ids: ids)
            print("background uploaded")
            task.setTaskCompleted(success: true)
        }.disposed(by: DisposeBag())
        
        scheduleBackgroundUploadImages()
    }
    
    func scheduleBackgroundUploadImages() {
        let uploadImagesTask = BGAppRefreshTaskRequest(identifier: "com.demo.uploadPhotos")
        //uploadImagesTask.earliestBeginDate = Date(timeIntervalSinceNow: 30)
        do {
          try BGTaskScheduler.shared.submit(uploadImagesTask)
        } catch {
            print("Unable to submit task: \(error.localizedDescription)")
        }
    }
}

