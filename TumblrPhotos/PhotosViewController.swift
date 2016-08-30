//
//  PhotosViewController.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/22/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class PhotosViewController: UIViewController {
    
    private struct Constants {
        static let SearchBarPlaceholder = "enter a tumblr blog name"
        static let TableViewEstimatedCellHeight = CGFloat(200.0)
    }
    
    private var blogPhotosViewModel: BlogPhotosViewModel?
    private let APIProvider: TumblrAPIProvider
    private let tableView = UITableView(frame: .zero)
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBar: UISearchBar { return searchController.searchBar }
    private let disposeBag = DisposeBag()
    
    required init(APIProvider: TumblrAPIProvider) {
        self.blogPhotosViewModel = nil
        self.APIProvider = APIProvider
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor.whiteColor()
        definesPresentationContext = true
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchBar.showsCancelButton = true
        searchBar.placeholder = Constants.SearchBarPlaceholder
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint.init(item: tableView, attribute: .Top, relatedBy: .Equal, toItem: topLayoutGuide, attribute: .Bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: tableView, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: 0)
            ])

        tableView.tableHeaderView = searchController.searchBar
        tableView.registerClass(PhotoPostCell.self, forCellReuseIdentifier: PhotoPostCell.defaultReuseIdentifier)
        tableView.estimatedRowHeight = Constants.TableViewEstimatedCellHeight
        
        self.blogPhotosViewModel = BlogPhotosViewModel(APIProvider: APIProvider)
        if let viewModel = self.blogPhotosViewModel {
            
            /* Bind incoming search text values from our UISearchBar to the view model variable. */
            searchBar.rx_text
                .bindTo(viewModel.blogNameVariable)
                .addDisposableTo(disposeBag)
            
            searchBar.rx_cancelButtonClicked
                .map{ "" }
                .bindTo(viewModel.blogNameVariable)
                .addDisposableTo(disposeBag)
            
            /* Bind the photo posts retrieved from the API to drive our UITableView. */
            viewModel.photoPosts
                .drive(tableView.rx_itemsWithCellIdentifier(PhotoPostCell.defaultReuseIdentifier)) { (_,  photoPost: PhotoPost, cell: PhotoPostCell) in
                    cell.setupCell(photoPost)
            }.addDisposableTo(disposeBag)
        }
        
        
    }
    
}