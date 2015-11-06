//
//  EBCardCollectionViewLayout.h
//  Vindeo
//
//  Created by Ezequiel A Becerra on 7/11/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EBCardCollectionLayoutType) {
    EBCardCollectionLayoutHorizontal,
    EBCardCollectionLayoutVertical
};

@interface EBCardCollectionViewLayout : UICollectionViewLayout

@property (readonly) NSInteger currentPage;
@property (nonatomic, assign) UIOffset offset;
@property (nonatomic, strong) NSDictionary *layoutInfo;
@property (assign) EBCardCollectionLayoutType layoutType;

- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath;
`
@end
