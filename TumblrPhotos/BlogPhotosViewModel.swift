//
//  BlogPhotosViewModel.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/22/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BlogPhotosViewModel {
    
    private struct Constants {
        static let DebounceDuration = 1.0
    }
    
    private let APIProvider: TumblrAPIProvider
    private let disposeBag = DisposeBag()
    
    // New elements on this variable kick off a blog photos request
    var blogNameVariable = Variable<String>("")
    
    // Data driving a tableview
    let photoPosts: Driver<[PhotoPost]>
    
    init(APIProvider: TumblrAPIProvider) {
        self.APIProvider = APIProvider
        
        photoPosts = blogNameVariable.asObservable()
            .debounce(Constants.DebounceDuration, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest {
                return APIProvider.loadBlogPhotos($0)
            }
            .asDriver(onErrorJustReturn: [])
    }
    
}