//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

@interface KTZoomAnimatedTransitioning (){
    NSTimeInterval forwardTime;
    NSTimeInterval reverseTime;
    CGFloat delay;
    CGFloat springDamping;
    CGFloat reverseSpringDamping;
    CGFloat springVelocity;
    CGAffineTransform transform;
}
@end

@implementation KTZoomAnimatedTransitioning

-(id)initWithRect:(CGRect)controlRectangle{
    self = [super init];
    if (self) {
        _controlRectangle = controlRectangle;
        forwardTime = 0.98f;
        reverseTime = 0.6f;
        delay = 0.0f;
        springDamping = 0.7f;
        reverseSpringDamping = 0.9f;
        springVelocity = 0.5f;
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
    
    [UIView animateWithDuration:forwardTime delay:delay usingSpringWithDamping:springDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
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
    
    [UIView animateWithDuration:reverseTime delay:delay usingSpringWithDamping:reverseSpringDamping initialSpringVelocity:springVelocity options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [snapshotView setCenter:[container center]];
        [snapshotView setFrame:[container frame]];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.reverse) {
        return reverseTime;
    }
    return forwardTime;
}

@end
