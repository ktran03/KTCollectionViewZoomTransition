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

-(id)initWithCollectionViewCell:(UICollectionViewCell*)cell{
    self = [super init];
    if (self) {
        _cell = cell;
    }
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    KTZoomAnimatedTransitioning *transitioning = [[KTZoomAnimatedTransitioning alloc] initWithCollectionViewCell:self.cell];
    return transitioning;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    KTZoomAnimatedTransitioning *transitioning = [KTZoomAnimatedTransitioning new];
    transitioning.reverse = YES;
    return transitioning;
}

@end
