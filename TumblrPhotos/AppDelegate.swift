//
//  AppDelegate.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/22/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        guard let window = window else { return false }
        
        let photosViewController = PhotosViewController(APIProvider: TumblrAPIProvider())
        
        window.rootViewController = photosViewController
        window.makeKeyAndVisible()
        
        return true
    }


}

