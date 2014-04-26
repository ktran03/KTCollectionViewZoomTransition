//
//  KTZoomAnimatedTransitioning.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomAnimatedTransitioning.h"

#define FORWARD_TIME 0.75f
#define REVERSE_TIME 0.45f
#define DELAY_TIME 0.0f
#define SPRING_DAMPING 0.7f
#define REVERSE_SPRING_DAMPING 0.9f
#define SPRING_VELOCITY 0.5f

@interface KTZoomAnimatedTransitioning (){
    CGAffineTransform transform;
}
@end

@implementation KTZoomAnimatedTransitioning

/**
 *  Init method
 *
 *  @param controlRectangle the rectangle to be zoomed in on
 *
 *  @return self
 */
-(id)initWithRect:(CGRect)controlRectangle{
    self = [super init];
    if (self) {
        _controlRectangle = controlRectangle;
    }
    return self;
}

/**
 *  Called when performing animation, determines forward or reverse
 *
 *  @param transitionContext : the transition context
 */
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self configureTransformation:transitionContext];
    self.reverse ? [self executeDismissAnimation:transitionContext] : [self executePresentationAnimation:transitionContext];
}

/**
 *  Performs calculation of transformation matrix
 *
 *  @param transitionContext : the transition context
 */
-(void)configureTransformation:(id<UIViewControllerContextTransitioning>)transitionContext{
    UIView *container = [transitionContext containerView];
    
    CGFloat sx = container.frame.size.width / self.controlRectangle.size.width;
    CGFloat sy = container.frame.size.height / self.controlRectangle.size.height;
    transform = CGAffineTransformMakeScale(sx, sy);
    
    CGFloat tx = container.center.x - CGRectGetMidX(self.controlRectangle);
    CGFloat ty = container.center.y - CGRectGetMidY(self.controlRectangle);
    transform = CGAffineTransformTranslate(transform, tx, ty);
}

/**
 *  Executes the presentation animation
 *
 *  @param transitionContext : the transition context
 */
-(void)executePresentationAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    
    UIView *snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    [snapshotView setFrame:CGRectMake(self.controlRectangle.origin.x, self.controlRectangle.origin.y, self.controlRectangle.size.width, self.controlRectangle.size.height)];
    UIView *combinedView = [fromViewController.view snapshotViewAfterScreenUpdates:NO];
    [combinedView insertSubview:snapshotView aboveSubview:fromViewController.view];
    [container addSubview:combinedView];
    
    [UIView animateWithDuration:FORWARD_TIME delay:DELAY_TIME usingSpringWithDamping:SPRING_DAMPING initialSpringVelocity:SPRING_VELOCITY options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        combinedView.transform = transform;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
    
}

/**
 *  Executes the dismiss animation
 *
 *  @param transitionContext : the transition context
 */
-(void)executeDismissAnimation:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    UIView *snapshotView = [toViewController.view snapshotViewAfterScreenUpdates:YES];
    
    snapshotView.transform = transform;
    [container addSubview:snapshotView];
    
    [UIView animateWithDuration:REVERSE_TIME delay:DELAY_TIME usingSpringWithDamping:REVERSE_SPRING_DAMPING initialSpringVelocity:SPRING_VELOCITY options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [snapshotView setCenter:[container center]];
        [snapshotView setFrame:[container frame]];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];
    }];
}

/**
 *  <#Description#>
 *
 *  @param transitionContext : the transition context
 *
 *  @return transition time
 */
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    if (self.reverse) {
        return REVERSE_TIME;
    }
    return FORWARD_TIME;
}

@end
