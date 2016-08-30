//
//  TumblrAPIProvider.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/26/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

final class TumblrAPIProvider {
    
    private struct Constants {
        static let APIKey = "U3Lwd94Cwg03j71ZYU8oUoEY4k5sfe3DlWRSwBQtz2OMs7HZ3Z"
        static let BaseURL = "https://api.tumblr.com/v2/"
        static let JSONResponseKey = "response"
        static let JSONPostsKey = "posts"
    }
    
    func loadBlogPhotos(blogName: String) -> Observable<[PhotoPost]> {
        
        guard !blogName.isEmpty else { return Observable.empty() }
        
        guard let URL = NSURL(string: Constants.BaseURL + "blog/\(blogName).tumblr.com/posts/photo?api_key=\(Constants.APIKey)") else { return Observable.empty() }
        
        return NSURLSession.sharedSession()
            .rx_JSON(NSURLRequest(URL: URL))
            .map {
                var data = [PhotoPost]()
                let posts = JSON($0)[Constants.JSONResponseKey][Constants.JSONPostsKey]
                
                for (_, postJSON): (String, JSON) in posts {
                    data.append(PhotoPost(json: postJSON))
                }
                
                return data
            }.catchErrorJustReturn([])
    }
    
}