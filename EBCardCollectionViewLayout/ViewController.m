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

- (void)viewDidLoad {
    [super viewDidLoad];
    UIOffset anOffset = UIOffsetMake(0, 10);
    [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - 

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                              forIndexPath:indexPath];    
    return retVal;
}

@end
