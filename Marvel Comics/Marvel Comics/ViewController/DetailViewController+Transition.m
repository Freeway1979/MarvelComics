//
//  DetailViewController+Transition.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "DetailViewController+Transition.h"
#import "LPTransitionAnimationPop.h"

@implementation DetailViewController (Transition)
#pragma mark -- UINavigationControllerDelegate --
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    if (operation == UINavigationControllerOperationPop) {
        return [LPTransitionAnimationPop new];
    }else{
        return nil;
    }
}
@end
