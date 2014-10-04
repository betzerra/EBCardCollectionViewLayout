//
//  EBCardCollectionViewLayout.m
//  Vindeo
//
//  Created by Ezequiel A Becerra on 7/11/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "EBCardCollectionViewLayout.h"

@interface EBCardCollectionViewLayout()
- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)cardWidth;
- (CGFloat)pageWidth;
@end

@implementation EBCardCollectionViewLayout

#pragma mark - Private

static NSString * const CellKind = @"CardCell";

- (NSInteger)cardWidth {
    NSInteger retVal = self.collectionView.bounds.size.width - _offset.horizontal * 2;
    return retVal;
}

- (CGFloat)pageWidth {
    CGFloat retVal = [self cardWidth] + _offset.horizontal/2;
    return retVal;
}

- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger posX = _offset.horizontal / 2 + [self pageWidth] * indexPath.row;
    
    CGRect retVal = CGRectMake(posX,
                               _offset.vertical,
                               [self cardWidth],
                               self.collectionView.bounds.size.height - _offset.vertical * 2);

    
    return retVal;
}

#pragma mark - Public

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

- (CGSize)collectionViewContentSize {
    CGSize retVal = CGSizeMake([self pageWidth] * [self.collectionView numberOfItemsInSection:0] + _offset.horizontal/2,
                               self.collectionView.bounds.size.height);
    return retVal;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGFloat rawPageValue = self.collectionView.contentOffset.x / [self pageWidth];

    CGFloat currentPage = 0;
    if (velocity.x > 0.0) {
        currentPage = floor(rawPageValue);
    } else {
        currentPage = ceil(rawPageValue);
    }
    
    CGFloat nextPage = 0;
    if (velocity.x > 0.0) {
        nextPage = ceil(rawPageValue);
    } else {
        nextPage = floor(rawPageValue);
    }
    
    BOOL pannedLessThanAPage = fabs(1 + currentPage - rawPageValue) > 0.5;
    BOOL flicked = fabs(velocity.x) > [self flickVelocity];
    if (pannedLessThanAPage && flicked) {
        proposedContentOffset.x = nextPage * [self pageWidth] - _offset.horizontal/2;
    } else {
        proposedContentOffset.x = round(rawPageValue) * [self pageWidth] - _offset.horizontal/2;
    }
    
    return proposedContentOffset;
}

- (CGFloat)flickVelocity {
    return 0.3;
}
@end
