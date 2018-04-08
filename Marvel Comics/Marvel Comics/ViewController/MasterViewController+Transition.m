//
//  MasterViewController+Transition.m
//  Marvel Comics
//
//  Created by Liu PingAn on 08/04/2018.
//  Copyright © 2018 Liu PingAn. All rights reserved.
//

#import "MasterViewController+Transition.h"
#import "LPTranstionAnimationPush.h"

@implementation MasterViewController (Transition)

#pragma mark -- UINavigationControllerDelegate --

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        return [LPTranstionAnimationPush new];
    }else{
        return nil;
    }
}
@end
