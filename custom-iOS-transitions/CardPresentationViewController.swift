//
//  CardPresentationViewController.swift
//  custom-iOS-transitions
//
//  Created by Austin Tooley on 2/5/18.
//  Copyright © 2018 Austin Tooley. All rights reserved.
//

import UIKit

class CardPresentationViewController: NSObject, UIViewControllerAnimatedTransitioning {

    let durationTime: Double = 5
//    var cellFrame : CGRect!
//    var cellTransform : CATransform3D!

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return durationTime
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let destination = transitionContext.viewController(forKey: .to) as! CardDetailViewController
        let containerView = transitionContext.containerView
        containerView.addSubview(destination.view)
        
        // Initial state
        let widthConstraint = destination.scrollView.widthAnchor.constraint(equalToConstant: 304)
        let heightConstraint = destination.scrollView.heightAnchor.constraint(equalToConstant: 248)
        let bottomConstraint = destination.scrollView.bottomAnchor.constraint(equalTo: destination.coverView.bottomAnchor)
        
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, bottomConstraint])
        
//        let translate = CATransform3DMakeTranslation(cellFrame.origin.x, cellFrame.origin.y, 0.0)
//        let tranform = CATransform3DConcat(translate, cellTransform)
//        
//        destination.view.layer.transform = tranform
//        destination.view.layer.zPosition = 999
        
        // Force update of constraints
        containerView.layoutIfNeeded()
        
        let animator = UIViewPropertyAnimator(duration: durationTime, dampingRatio: 0.7) {
            // End state
            NSLayoutConstraint.deactivate([widthConstraint, heightConstraint, bottomConstraint])
            destination.view.layer.transform = CATransform3DIdentity
            
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion { (finished) in
            // Completion
            transitionContext.completeTransition(true)
        }
        
        animator.startAnimation()
    }
    
}
