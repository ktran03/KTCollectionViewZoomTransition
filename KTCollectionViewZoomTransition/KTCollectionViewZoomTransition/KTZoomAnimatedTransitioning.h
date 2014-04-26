//
//  KTZoomAnimatedTransitioning.h
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTZoomAnimatedTransitioning : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  The rectangle to be zoomed in on
 */
@property (assign) CGRect controlRectangle;

/**
 *  BOOL that signifies if in reverse transition mode
 */
@property (nonatomic) BOOL reverse;

/**
 *  Init method
 *
 *  @param controlRectangle : the rect to be zoomed in on
 *
 *  @return : self
 */
-(id)initWithRect:(CGRect)controlRectangle;

    
@end
