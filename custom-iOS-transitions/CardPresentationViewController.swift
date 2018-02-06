//
//  CardPresentationViewController.swift
//  custom-iOS-transitions
//
//  Created by Austin Tooley on 2/5/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit

class CardPresentationViewController: NSObject, UIViewControllerAnimatedTransitioning {

    let durationTime: Double = 0.7
    var cardFrame : CGRect!

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let destination = transitionContext.viewController(forKey: .to) as! CardDetailViewController
        let containerView = transitionContext.containerView
        containerView.addSubview(destination.view)
        
        // MARK: Transition Initial State
        let widthConstraint = destination.scrollView.widthAnchor.constraint(equalToConstant: cardFrame.width)
        let heightConstraint = destination.scrollView.heightAnchor.constraint(equalToConstant: cardFrame.height)
        let bottomConstraint = destination.scrollView.bottomAnchor.constraint(equalTo: destination.coverView.bottomAnchor)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, bottomConstraint])
        
        // Place over the card
        let translate = CATransform3DMakeTranslation(cardFrame.origin.x, cardFrame.origin.y, 0.0)
        destination.view.layer.transform = translate
        destination.view.layer.zPosition = 999
        containerView.layoutIfNeeded() // force update if needed
        
        // Make it look like the card's cover image
        destination.scrollView.layer.cornerRadius = 14
        destination.scrollView.layer.shadowOpacity = 0.25
        destination.scrollView.layer.shadowOffset.height = 10
        destination.scrollView.layer.shadowRadius = 20
        
        // Extra animations for close button and content
        let moveUpTransform = CGAffineTransform(translationX: 0, y: -100)
        let scaleUpTranform = CGAffineTransform(scaleX: 2, y: 2)
        let removeFromViewTransform = moveUpTransform.concatenating(scaleUpTranform)
        
        destination.closeButtonView.alpha = 0
        destination.closeButtonView.transform = removeFromViewTransform
        
        let animator = UIViewPropertyAnimator(duration: durationTime, dampingRatio: 0.7) {
            // MARK: Transition Final State
            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint, bottomConstraint])
            destination.view.layer.transform = CATransform3DIdentity
            containerView.layoutIfNeeded()
            
            // Reset to normal
            destination.scrollView.layer.cornerRadius = 0
            destination.closeButtonView.alpha = 1
            destination.closeButtonView.transform = .identity
            
            // Final title state
            let scaleTranform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            let moveTransform = CGAffineTransform(translationX: 30, y: 10)
            let titleTranform = scaleTranform.concatenating(moveTransform)
            
            destination.titleLabel.transform = titleTranform
        }
        
        animator.addCompletion { (finished) in
            // MARK: Transition Completion
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    
}
