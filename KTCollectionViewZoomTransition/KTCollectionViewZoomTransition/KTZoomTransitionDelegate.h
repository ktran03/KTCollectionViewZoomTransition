//
//  KTZoomTransitionDelegate.h
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTZoomTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (assign) CGRect aRect;

-(id)initWithRect:(CGRect)rect;

@end
