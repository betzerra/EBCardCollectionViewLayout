//
//  EBCardCollectionViewLayout.m
//  Vindeo
//
//  Created by Ezequiel A Becerra on 7/11/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "EBCardCollectionViewLayout.h"

@interface EBCardCollectionViewLayout()
- (void)setup;
- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath;
@end

@implementation EBCardCollectionViewLayout

#pragma mark - Private

static NSString * const CellKind = @"CardCell";

- (void)setup{

}

- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath{
    CGRect retVal = CGRectMake(indexPath.row * self.collectionView.bounds.size.width + _offset.horizontal,
                               _offset.vertical,
                               self.collectionView.bounds.size.width - _offset.horizontal * 2,
                               self.collectionView.bounds.size.height - _offset.vertical * 2);
    return retVal;
}

#pragma mark - Public

- (id)init{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib{
    [self setup];
}

- (void)prepareLayout{
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            itemAttributes.frame = [self frameForCardAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = itemAttributes;
        }
    }
    
    newLayoutInfo[@"CellKind"] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    
    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
            
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                [allAttributes addObject:attributes];
            }
        }];
    }];
    
    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *retVal = self.layoutInfo[indexPath];
    return retVal;
}

- (CGSize)collectionViewContentSize{
    CGSize retVal = CGSizeMake(self.collectionView.bounds.size.width * [self.collectionView numberOfItemsInSection:0],
                               self.collectionView.bounds.size.height);
    return retVal;
}
@end
