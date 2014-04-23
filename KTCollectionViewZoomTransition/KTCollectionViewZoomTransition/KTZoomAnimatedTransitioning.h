//
//  KTZoomAnimatedTransitioning.h
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTZoomAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

@property (assign) CGRect controlRectangle;
@property (nonatomic) BOOL reverse;


-(id)initWithRect:(CGRect)controlRectangle;

    
@end
