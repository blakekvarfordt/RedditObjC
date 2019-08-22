//
//  PostTableViewCell.swift
//  RedditObjC
//
//  Created by Blake kvarfordt on 8/22/19.
//  Copyright © 2019 Blake kvarfordt. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    
    // Outlets
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var upsLabel: UILabel!
    @IBOutlet weak var commentCountLabel: UILabel!
    
    // Properties
    var post: BTKPost? {
        didSet {
            updateViews()
        }
    }
    
    var thumbnail: UIImage? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let post = post else { return }
        titleLabel.text = post.title
        upsLabel.text = "❤️ \(post.ups)"
        commentCountLabel.text = "\(post.commentCount)"
        postImageView.image = thumbnail
        
    }
    
    

}

