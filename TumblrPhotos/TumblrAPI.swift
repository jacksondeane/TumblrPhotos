//
//  TumblrAPI.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/24/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import Moya

struct TumblrAPIConstants {
    static var APIKey = "U3Lwd94Cwg03j71ZYU8oUoEY4k5sfe3DlWRSwBQtz2OMs7HZ3Z"
    static var BaseURL = NSURL(string: "https://api.tumblr.com/v2/")
}

enum TumblrPostType: String {
    case Photo = "photo"
}

enum TumblrAPI {
    case Posts(blogIdentifier: String, type: TumblrPostType)
}

extension TumblrAPI: TargetType {
    
    var baseURL: NSURL {
        return TumblrAPIConstants.BaseURL ?? NSURL()
    }
    
    var path: String {
        switch self {
        case .Posts(let blogIdentifier, let type):
            return "blog/\(blogIdentifier).tumblr.com/posts/\(type.rawValue)"
        }
    }
    
    var method: Moya.Method {
        return .GET
    }
    
    var parameters: [String: AnyObject]? {
        return ["api_key" : TumblrAPIConstants.APIKey]
    }
    
    var multipartBody: [MultipartFormData]? {
        return nil
    }
    
    var sampleData: NSData {
        switch self {
        case .Posts(_):
            return "{\"user\" : \"BLAH\", \"id\" : \"100\"}".dataUsingEncoding(NSUTF8StringEncoding)! //TODO: Real sample data
        }
    }
}

