//
//  KTViewController.m
//  KTCollectionViewZoomTransition
//
//  Created by khanh tran on 2014-04-21.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTViewController.h"
#import "KTCollectionViewCell.h"
#import "KTSecondViewController.h"
#import "KTZoomTransitionDelegate.h"

@interface KTViewController ()

@end

@implementation KTViewController

/**
 *  VC lifecycle methods
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.collectionView registerClass:[KTCollectionViewCell class] forCellWithReuseIdentifier:@"basic cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UICollectionview methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KTCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"basic cell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{    
    KTSecondViewController *vc = (KTSecondViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"second vc"];
    
    id <UIViewControllerTransitioningDelegate> delegate = [[KTZoomTransitionDelegate alloc] initWithCollectionViewCell:[collectionView cellForItemAtIndexPath:indexPath]];
    vc.transitioningDelegate = delegate;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
