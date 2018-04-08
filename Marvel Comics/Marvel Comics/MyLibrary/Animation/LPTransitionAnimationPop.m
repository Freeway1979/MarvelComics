//
//  LPTransitionAnimationPop.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPTransitionAnimationPop.h"

@interface LPTransitionAnimationPop()<CAAnimationDelegate>

@property (nonatomic, strong) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation LPTransitionAnimationPop

#pragma mark -- UIViewControllerAnimatedTransitioning --

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.6;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    

    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containView = [transitionContext containerView];
    [containView addSubview:toVc.view];
    [containView addSubview:fromVc.view];
    
    CGRect frame = CGRectMake(60, 60, 6, 6);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:frame];
    
    
    CGPoint startPoint;
    if (frame.origin.x > toVc.view.center.x) {
        if (frame.origin.y < toVc.view.center.y) {
            startPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }
        else
        {
            startPoint = CGPointMake(0, 0);
        }
    }
    else{
        if (frame.origin.y < toVc.view.center.y) {
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }
        else
        {
            startPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
        
    }
    
    CGPoint endPoint = CGPointMake(frame.origin.x, frame.origin.y);
    CGFloat radius = sqrt((endPoint.x-startPoint.x) * (endPoint.x-startPoint.x) + (endPoint.y-startPoint.y) * (endPoint.y-startPoint.y)) - sqrt((frame.size.width/2 * frame.size.width/2) + (frame.size.height/2 * frame.size.height/2));
    
    //From large to small
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(frame, -radius, -radius)];
    
    // 
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    fromVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id)startPath.CGPath;
    animation.toValue = (__bridge id)endPath.CGPath;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:nil];
}


#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    [self.transitionContext completeTransition:YES];
    
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
    
}

@end
