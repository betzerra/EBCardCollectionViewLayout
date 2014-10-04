//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "ViewController.h"
#import "EBCardCollectionViewLayout.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Public

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  The bigger the offset, the more you see on previous / next cards.
    UIOffset anOffset = UIOffsetMake(40, 10);
    [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                              forIndexPath:indexPath];    
    return retVal;
}

@end
