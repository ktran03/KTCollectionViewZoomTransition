//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

@interface KTZoomAnimatedTransitioning (){
    UIView *snapshotView;
    UIView *combinedView;
}
@end

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
    self.reverse ? [self executeDismissAnimation:transitionContext] : [self executePresentationAnimation:transitionContext];
}

-(void)executeDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    
    CGFloat widthScale = container.frame.size.width / self.controlRectangle.size.width;
    CGFloat heightScale = container.frame.size.height / self.controlRectangle.size.height;
    CGAffineTransform transform = CGAffineTransformMakeScale(widthScale, heightScale);
    
    CGPoint centerScreen = container.center;
    CGPoint centerZoomedRect = CGPointMake(CGRectGetMidX(self.controlRectangle), CGRectGetMidY(self.controlRectangle));
    CGFloat tx = centerScreen.x - centerZoomedRect.x;
    CGFloat ty = centerScreen.y - centerZoomedRect.y;
    transform = CGAffineTransformTranslate(transform, tx, ty);
    
    snapshotView.transform = transform;
    [container addSubview:snapshotView];

    
    
    [UIView animateWithDuration:.6 delay:0.0 usingSpringWithDamping:0.9f initialSpringVelocity:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [snapshotView setCenter:[container center]];
        [snapshotView setFrame:[container frame]];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    [snapshotView setFrame:CGRectMake(self.controlRectangle.origin.x, self.controlRectangle.origin.y, self.controlRectangle.size.width, self.controlRectangle.size.height)];
    combinedView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    [combinedView insertSubview:snapshotView aboveSubview:fromViewController.view];
    [container addSubview:combinedView];
    
    CGFloat widthScale = container.frame.size.width / self.controlRectangle.size.width;
    CGFloat heightScale = container.frame.size.height / self.controlRectangle.size.height;
    
    CGAffineTransform transform = CGAffineTransformMakeScale(widthScale, heightScale);
    
    CGPoint centerScreen = container.center;
    CGPoint centerZoomedRect = CGPointMake(CGRectGetMidX(self.controlRectangle), CGRectGetMidY(self.controlRectangle));
    CGFloat tx = centerScreen.x - centerZoomedRect.x;
    CGFloat ty = centerScreen.y - centerZoomedRect.y;
    transform = CGAffineTransformTranslate(transform, tx, ty);
    
    
    [UIView animateWithDuration:.6 delay:0.0 usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        if (self.reverse) {
            combinedView.transform = CGAffineTransformMakeScale(0, 0);
        }
        else {
            combinedView.transform = transform;
        }
    } completion:^(BOOL finished) {
        [combinedView removeFromSuperview];
        [transitionContext completeTransition:finished];
    }];
    
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.15f;
}

@end
