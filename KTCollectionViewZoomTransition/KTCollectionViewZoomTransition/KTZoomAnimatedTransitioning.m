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


    if (self.reverse) {
        [container insertSubview:toViewController.view belowSubview:fromViewController.view];
    }
    else {
        [container addSubview:fromViewController.view];
    }
    
    [UIView animateKeyframesWithDuration:5.0f delay:0 options:0 animations:^{
        if (self.reverse) {
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            CGFloat widthScale = fromViewController.view.frame.size.width / self.aRect.size.width;
            CGFloat heightScale = fromViewController.view.frame.size.height / self.aRect.size.height;

            fromViewController.view.transform = CGAffineTransformMakeScale(widthScale, heightScale);
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
