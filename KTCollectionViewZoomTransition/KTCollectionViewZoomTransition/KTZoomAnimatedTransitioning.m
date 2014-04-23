//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

@implementation KTZoomAnimatedTransitioning

-(id)initWithRect:(CGRect)controlRectangle{
    self = [super init];
    if (self) {
        _controlRectangle = controlRectangle;
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
        UIView *snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
        [snapshotView setFrame:CGRectMake(self.controlRectangle.origin.x, self.controlRectangle.origin.y, self.controlRectangle.size.width, self.controlRectangle.size.height)];
        [fromViewController.view insertSubview:snapshotView aboveSubview:fromViewController.view];
    }
    
    
    CGFloat widthScale = fromViewController.view.frame.size.width / self.controlRectangle.size.width;
    CGFloat heightScale = fromViewController.view.frame.size.height / self.controlRectangle.size.height;
    
    CGAffineTransform transform = fromViewController.view.transform;
    transform = CGAffineTransformMakeScale(widthScale, heightScale);
    
    CGPoint centerScreen = fromViewController.view.center;
    CGPoint centerZoomedRect = CGPointMake(CGRectGetMidX(self.controlRectangle), CGRectGetMidY(self.controlRectangle));
    CGFloat tx = centerScreen.x - centerZoomedRect.x;
    CGFloat ty = centerScreen.y - centerZoomedRect.y;
    transform = CGAffineTransformTranslate(transform, tx, ty);
    
    
    [UIView animateWithDuration:.7 delay:0.0 usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        if (self.reverse) {
            fromViewController.view.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            fromViewController.view.transform = transform;
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
