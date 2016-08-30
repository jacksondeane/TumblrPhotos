//
//  RemoteLoadedImage.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/30/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromURL(URL: NSURL){
        let request = NSURLRequest(URL: URL);
        let datatask = NSURLSession.sharedSession().dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if let data = data {
                dispatch_async(dispatch_get_main_queue()) {
                    self.image = UIImage(data: data)
                }
            }
            else if let error = error {
                print(error.localizedDescription)
            }
        }
        datatask.resume()
    }
}