//
//  FlipPresentAnimationController.m
//  Marvel Comics
//
//  Created by Liu PingAn on 05/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "FlipPresentAnimationController.h"
#import <CoreGraphics/CoreGraphics.h>

@interface FlipPresentAnimationController ()
{
    CGRect originalFrame ;
}
@end

@implementation FlipPresentAnimationController

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey: UITransitionContextFromViewControllerKey];
    if (!fromVC) {
        return;
    }
    
    //UIView * containerView = transitionContext.containerView;
    
    UIViewController * toVC = [transitionContext viewControllerForKey: UITransitionContextToViewControllerKey];
    
    CGRect initialFrame = CGRectZero;
    //CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    UIView *snapshot = [toVC.view snapshotViewAfterScreenUpdates:TRUE];
    snapshot.frame = initialFrame ;
    snapshot.layer.cornerRadius = 25;
    snapshot.layer.masksToBounds = TRUE;
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 2.0f;
}



@end
