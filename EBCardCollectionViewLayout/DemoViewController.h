//
//  ViewController.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>
@import EBCardCollectionViewLayout;

@interface DemoViewController : UIViewController <UICollectionViewDataSource>{
    NSMutableArray *_people;
    __weak IBOutlet UICollectionView *_collectionView;
}

- (IBAction)addFirstButtonPressed:(id)sender;
- (IBAction)addLastButtonPressed:(id)sender;
- (IBAction)removeFirstButtonPressed:(id)sender;
- (IBAction)removeLastButtonPressed:(id)sender;

@property (assign) EBCardCollectionLayoutType layoutType;

@end
