//
//  ViewController.swift
//  custom-iOS-transitions
//
//  Created by Austin Tooley on 2/5/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var cardView: UIView!
    
    let cardPresentationViewController = CardPresentationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCard()
    }
    
    func configureCard() {
        
        // Corners and shadow
        cardView.layer.cornerRadius = 14
        cardView.layer.shadowOpacity = 0.25
        cardView.layer.shadowOffset = CGSize(width: 0, height: 10)
        cardView.layer.shadowRadius = 10
        coverImage.contentMode = .scaleAspectFill
        coverImage.clipsToBounds = true
        coverImage.layer.cornerRadius = 14
        
        // Content
        titleLabel.text = CardData.shared.title
        captionLabel.text = CardData.shared.caption
        coverImage.image = CardData.shared.coverImage
    }

    @IBAction func cardTapped(_ sender: Any) {
        performSegue(withIdentifier: "cardDetailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cardDetailSegue", let destination = segue.destination as? CardDetailViewController {
            destination.titleText = CardData.shared.title
            destination.caption = CardData.shared.caption
            destination.cover = CardData.shared.coverImage
            destination.descriptionText = CardData.shared.description
            destination.transitioningDelegate = self
            
            // Prep for animation
//            let cellFrame = destination.view.frame
//            cardPresentationViewController.cellFrame = cellFrame
//            cardPresentationViewController.cellTransform = animateCell(cellFrame: cellFrame)
            
        }
    }
    
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}

// MARK: Extensions

/*****
 * Transition Delegates refer a view controller to where it can find a transition. Everytime an object asks `ViewController`
 * which transition to perform, return `cardPresentationViewController`.
 *****/
extension ViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return cardPresentationViewController
    }
}
