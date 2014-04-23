## KTCollectionViewZoomTransition

<p align=“left” >
  <img src="http://i.imgur.com/tJ0GjMl.gif" alt=“KTCustomSlider” title=“KT”KTCollectionViewZoomTransition>
</p>


Custom transition mimicking Apple’s native calendar and photos app. Intended to be used with collection view cells, but any view could be used.


## Usage

```objective-c

//Import transition delegate
#import "KTZoomTransitionDelegate.h"

//create property for the transition
@property (nonatomic, strong) KTZoomTransitionDelegate *transitioningDelegate;

//Collection view method
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{    

    //get cell’s frame in relation to view controller
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    CGRect cellFrame = [collectionView convertRect:cell.frame toView:self.view];

    //init the custom transition with the cell frame
    self.transitioningDelegate = [[KTZoomTransitionDelegate alloc] initWithRect:cellFrame];
    vc.transitioningDelegate = self.transitioningDelegate;

    //present your desired view controller
    UIViewController *vc = (UIViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"second vc"];
    [self presentViewController:vc animated:YES completion:nil];
}

```

## Maintainer

- [Khanh Tran](http://github.com/ktran03) ([@khanhvinhtran](https://twitter.com/KhanhVinhTran)) 


## Questions - Comments - Suggestions

Contact above.

## License
KTCollectionViewZoomTransition is available under the MIT license. See license file for more info.