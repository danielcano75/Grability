//
//  FadeInAnimator.swift
//  Test
//
//  Created by Jorge Cano on 18/05/16.
//  Copyright © 2016 Daniel. All rights reserved.
//

import UIKit
import Foundation

class FadeInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return 0.35
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        let containerView = transitionContext.containerView()
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        containerView!.addSubview(toVC!.view)
        toVC!.view.alpha = 0.0
        
        let duration = transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, animations: {
            toVC!.view.alpha = 1.0
            }, completion: { finished in
                let cancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!cancelled)
        })
    }
    
}
