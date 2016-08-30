//
//  PhotoPostCell.swift
//  TumblrPhotos
//
//  Created by Jackson Deane on 8/29/16.
//  Copyright © 2016 Jackson Deane. All rights reserved.
//

import Foundation
import UIKit

final class PhotoPostCell: UITableViewCell {
    
    private let photoView =  UIImageView(frame: .zero)
    private var cellHeightConstraint: NSLayoutConstraint
    
    static var defaultReuseIdentifier: String {
        return String(self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        cellHeightConstraint = NSLayoutConstraint()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        photoView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(photoView)
        NSLayoutConstraint.activateConstraints([
            NSLayoutConstraint.init(item: photoView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: photoView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: photoView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: photoView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: 0)
            ])
        
        
        cellHeightConstraint = NSLayoutConstraint.init(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 0)
        cellHeightConstraint.priority = 999
        NSLayoutConstraint.activateConstraints([cellHeightConstraint])
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        photoView.image = nil
    }
    
    func setupCell(photoPost: PhotoPost) {
        if let photoURL = photoPost.photoURL,
           let photoSize = photoPost.photoSize {
            photoView.loadImageFromURL(photoURL)
            
            /* Calculate and set the required height to maintain the photo aspect ratio inside the tableview */
            let photoAspectRatio = photoSize.height / photoSize.width
            cellHeightConstraint.constant = contentView.frame.size.width * photoAspectRatio
        }
    }
    
}

