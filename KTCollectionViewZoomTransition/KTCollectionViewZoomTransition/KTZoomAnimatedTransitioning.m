//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

@interface KTZoomAnimatedTransitioning (){
    CGAffineTransform transform;
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
    [self configureTransformation:transitionContext];
    self.reverse ? [self executeDismissAnimation:transitionContext] : [self executePresentationAnimation:transitionContext];
}

-(void)configureTransformation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *container = [transitionContext containerView];
    
    CGFloat sx = container.frame.size.width / self.controlRectangle.size.width;
    CGFloat sy = container.frame.size.height / self.controlRectangle.size.height;
    transform = CGAffineTransformMakeScale(sx, sy);
    
    CGPoint centerControlRect = CGPointMake(CGRectGetMidX(self.controlRectangle), CGRectGetMidY(self.controlRectangle));
    CGFloat tx = container.center.x - centerControlRect.x;
    CGFloat ty = container.center.y - centerControlRect.y;
    transform = CGAffineTransformTranslate(transform, tx, ty);
}

-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    [snapshotView setFrame:CGRectMake(self.controlRectangle.origin.x, self.controlRectangle.origin.y, self.controlRectangle.size.width, self.controlRectangle.size.height)];
    UIView *combinedView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    [combinedView insertSubview:snapshotView aboveSubview:fromViewController.view];
    [container addSubview:combinedView];
    
    [UIView animateWithDuration:.6 delay:0.0 usingSpringWithDamping:0.7f initialSpringVelocity:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        combinedView.transform = transform;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
    
}

-(void)executeDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    UIView *snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    
    snapshotView.transform = transform;
    [container addSubview:snapshotView];
    
    [UIView animateWithDuration:.42 delay:0.0 usingSpringWithDamping:0.9f initialSpringVelocity:0.5f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [snapshotView setCenter:[container center]];
        [snapshotView setFrame:[container frame]];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.reverse) {
        return .42f;
    }
    return 0.6f;
}

@end
