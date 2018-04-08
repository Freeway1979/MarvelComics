//
//  LPTranstionAnimationPush.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "LPTranstionAnimationPush.h"

@interface LPTranstionAnimationPush()<CAAnimationDelegate>

@property (nonatomic, strong)id<UIViewControllerContextTransitioning> transitionContext;

@end
@implementation LPTranstionAnimationPush
#pragma mark -- UIViewControllerAnimatedTransitioning --

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.7;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    self.transitionContext = transitionContext;
    
    UIViewController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIViewController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    UIView *containView = [transitionContext containerView];
    [containView addSubview:fromVc.view];
    [containView addSubview:toVc.view];
    
    CGRect frame = CGRectMake(60,60, 60, 60);
    
    UIBezierPath *startPath = [UIBezierPath bezierPathWithOvalInRect:frame];

    CGPoint finalPoint;
  
    if(frame.origin.x > (toVc.view.bounds.size.width / 2)){
        if (frame.origin.y < (toVc.view.bounds.size.height / 2)) {
            finalPoint = CGPointMake(0, CGRectGetMaxY(toVc.view.frame));
        }else{
            finalPoint = CGPointMake(0, 0);
        }
    }else{
        if (frame.origin.y < (toVc.view.bounds.size.height / 2)) {
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), CGRectGetMaxY(toVc.view.frame));
        }else{
            finalPoint = CGPointMake(CGRectGetMaxX(toVc.view.frame), 0);
        }
    }
    
    CGPoint startPoint = CGPointMake(frame.origin.x,frame.origin.y);
    
    CGFloat radius = sqrt((finalPoint.x-startPoint.x) * (finalPoint.x-startPoint.x) + (finalPoint.y-startPoint.y) * (finalPoint.y-startPoint.y)) - sqrt(frame.size.width/2 * frame.size.width/2 + frame.size.height/2 * frame.size.height/2);
    UIBezierPath *endPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = endPath.CGPath;
    toVc.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskAnimation =[CABasicAnimation animationWithKeyPath:@"path"];
    maskAnimation.fromValue = (__bridge id)startPath.CGPath;
    maskAnimation.toValue = (__bridge id)endPath.CGPath;
    maskAnimation.duration = [self transitionDuration:transitionContext];
    maskAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    maskAnimation.delegate = self;
    [maskLayer addAnimation:maskAnimation forKey:@"path"];
    
}

#pragma mark -- CAAnimationDelegate --

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self.transitionContext completeTransition:YES];
    [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
