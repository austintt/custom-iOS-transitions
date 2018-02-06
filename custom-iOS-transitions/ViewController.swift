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
            
            // Pass in the data
            destination.titleText = CardData.shared.title
            destination.caption = CardData.shared.caption
            destination.cover = CardData.shared.coverImage
            destination.descriptionText = CardData.shared.description
            destination.transitioningDelegate = self
            
            // Prep for animation
            let cardFrame = self.view.convert(cardView.frame, to: view)
            cardPresentationViewController.cardFrame = cardFrame
        }
    }
}

// MARK: Transition Extensions

/*****
 * Transition Delegates refer a view controller to where it can find a transition. Everytime an object asks `ViewController`
 * which transition to perform, return the desired presentation controller.
 *****/
extension ViewController : UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return cardPresentationViewController
    }
    
    // TODO: Create a CardDismissalViewController
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return cardDismissalViewController
//    }
}
