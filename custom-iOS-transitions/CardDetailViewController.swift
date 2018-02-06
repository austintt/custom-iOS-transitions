//
//  CardDetailViewController.swift
//  custom-iOS-transitions
//
//  Created by Austin Tooley on 2/5/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit

class CardDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    var titleText: String!
    var caption: String!
    var cover: UIImage!
    var descriptionText: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        captionLabel.text = caption
        descriptionLabel.text = descriptionText
        coverImage.image = cover
    }
}
