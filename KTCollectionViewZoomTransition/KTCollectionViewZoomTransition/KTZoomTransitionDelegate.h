//
//  KTZoomTransitionDelegate.h
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTZoomTransitionDelegate : NSObject <UIViewControllerTransitioningDelegate>

/**
 *  the rect to be zoomed in (could be UICollectionViewCell or other view)
 */
@property (nonatomic, assign) CGRect controlRect;

/**
 *  Init method
 *
 *  @param controlRect : the rect to be zoomed in on
 *
 *  @return : self
 */
-(id)initWithRect:(CGRect)controlRect;

@end
