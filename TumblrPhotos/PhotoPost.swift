//
//  PhotoPost.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/22/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PhotoPost {
    
    struct JSONKeys {
        static let PhotosKey = "photos"
        static let OriginalSizePhotoKey = "original_size"
        static let PhotoURLKey = "url"
        static let PhotoWidthKey = "width"
        static let PhotoHeightKey = "height"
    }
    
    let photoURL: NSURL?
    let photoSize: CGSize?
    
    init(json: JSON) {
        if let originalSizePhoto = json[JSONKeys.PhotosKey].arrayValue[0].dictionaryValue[JSONKeys.OriginalSizePhotoKey]?.dictionaryValue,
           let photoURLValue = originalSizePhoto[JSONKeys.PhotoURLKey]?.string,
           let widthValue = originalSizePhoto[JSONKeys.PhotoWidthKey]?.doubleValue,
           let heightValue = originalSizePhoto[JSONKeys.PhotoHeightKey]?.doubleValue {
            photoURL = NSURL(string: photoURLValue)
            photoSize = CGSize(width: widthValue, height: heightValue)
        }
        else {
            photoURL = nil
            photoSize = nil
        }
    }
}