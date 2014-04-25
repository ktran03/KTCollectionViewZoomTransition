//
//  KTAppDelegate.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTAppDelegate.h"
#import "KTZoomTransitionDelegate.h"


@interface KTAppDelegate ()
@property (nonatomic, strong) KTZoomTransitionDelegate *transitioningDelegate;
@end

@implementation KTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.transitioningDelegate = [KTZoomTransitionDelegate new];
    self.window.rootViewController.transitioningDelegate = self.transitioningDelegate;
    return YES;
}

@end
