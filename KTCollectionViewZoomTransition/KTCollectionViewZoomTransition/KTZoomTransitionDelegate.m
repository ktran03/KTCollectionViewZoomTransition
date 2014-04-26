//
//  KTZoomTransitionDelegate.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTZoomTransitionDelegate.h"
#import "KTZoomAnimatedTransitioning.h"

@implementation KTZoomTransitionDelegate

/**
 *  Init method
 *
 *  @param controlRect : the rect to be zoomed in and out
 *
 *  @return self
 */
-(id)initWithRect:(CGRect)controlRect{
    self = [super init];
    if (self) {
        _controlRect = controlRect;
    }
    return self;
}

/**
 *  Called when transition presenting a view controller.
 *
 *  @param presented  the presented view controller
 *  @param presenting the presenting view controller
 *  @param source     the view controller that called presentViewController:animated:
 *
 *  @return KTZoomAnimatedTransitioning instance
 */
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    KTZoomAnimatedTransitioning *transitioning = [[KTZoomAnimatedTransitioning alloc] initWithRect:_controlRect];
    return transitioning;
}

/**
 *  Called when transition dismisses view controller
 *
 *  @param dismissed the view controller to be dismissed
 *
 *  @return KTZoomAnimatedTransitioning instance
 */
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    KTZoomAnimatedTransitioning *transitioning = [[KTZoomAnimatedTransitioning alloc] initWithRect:_controlRect];
    transitioning.reverse = YES;
    return transitioning;
}

@end
