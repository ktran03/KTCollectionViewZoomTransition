//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

@implementation KTZoomAnimatedTransitioning

-(id)initWithRect:(CGRect)rect{
    self = [super init];
    if (self) {
        _aRect = rect;
    }
    return self;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
//
//
//    [container addSubview:fromViewController.view];
//    [container insertSubview:toViewController.view aboveSubview:fromViewController.view];
//    

    if (self.reverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    }
    else {
        
//        CGAffineTransform transform = toViewController.view.transform;
//        toViewController.view.transform = CGAffineTransformScale(transform, 0.5f, 0.5f);
        
        
        [toViewController.view setFrame:CGRectMake(self.aRect.origin.x, self.aRect.origin.y, self.aRect.size.width, self.aRect.size.height)];

        [container addSubview:toViewController.view];
    }
    
    [UIView animateKeyframesWithDuration:0.5f delay:0 options:0 animations:^{
        if (self.reverse) {
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1);
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.15f;
}

@end
