//
//  EBCardCollectionViewLayout.m
//  Vindeo
//
//  Created by Ezequiel A Becerra on 7/11/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "EBCardCollectionViewLayout.h"

@interface EBCardCollectionViewLayout()
- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath;
- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)cardWidth;
- (CGFloat)pageWidth;
- (void)setup;
@end

@implementation EBCardCollectionViewLayout

#pragma mark - Private

static NSString * const CellKind = @"CardCell";

- (void)setup {
    [self addObserver:self forKeyPath:@"collectionView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSInteger)cardWidth {
    NSInteger retVal = self.collectionView.bounds.size.width - _offset.horizontal * 2;
    return retVal;
}

- (CGFloat)pageWidth {
    CGFloat retVal = [self cardWidth] + _offset.horizontal/2;
    return retVal;
}

- (NSString *)keyForIndexPath:(NSIndexPath *)indexPath {
    NSString *retVal = [NSString stringWithFormat:@"%d-%d", indexPath.section, indexPath.row];
    return retVal;
}

- (CGRect)frameForCardAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger posX = _offset.horizontal / 2 + [self pageWidth] * indexPath.row;
    
    if ([self.collectionView numberOfItemsInSection:0] == 1) {
        //  If there's just an only item. Center it.
        posX = _offset.horizontal + [self pageWidth] * indexPath.row;
    }
    
    CGRect retVal = CGRectMake(posX,
                               _offset.vertical,
                               [self cardWidth],
                               self.collectionView.bounds.size.height - _offset.vertical * 2);

    
    return retVal;
}

#pragma mark - Properties

- (void)setOffset:(UIOffset)offset {
    _offset = offset;
    [self invalidateLayout];
}

#pragma mark - Public

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)awakeFromNib {
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
            
            NSString *key = [self keyForIndexPath:indexPath];
            cellLayoutInfo[key] = itemAttributes;
        }
    }
    
    newLayoutInfo[@"CellKind"] = cellLayoutInfo;
    self.layoutInfo = newLayoutInfo;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = [self keyForIndexPath:indexPath];
    UICollectionViewLayoutAttributes *retVal = self.layoutInfo[@"CellKind"][key];
    return retVal;
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
    CGSize retVal = CGSizeMake([self pageWidth] * [self.collectionView numberOfItemsInSection:0] + _offset.horizontal,
                               self.collectionView.bounds.size.height);
    return retVal;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGPoint retVal = proposedContentOffset;
    
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
        
        //  Change UICollectionViewCell
        retVal.x = nextPage * [self pageWidth];
        
        if (nextPage != [self.collectionView numberOfItemsInSection:0]-1) {
            retVal.x = retVal.x - _offset.horizontal/2;
        }
        
    } else {
        //  Bounces
        CGFloat posX = round(rawPageValue) * [self pageWidth] - _offset.horizontal/2;
        posX = MAX(0, posX);
        retVal.x = posX;
    }
    
    return retVal;
}

- (CGFloat)flickVelocity {
    return 0.3;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    if ([keyPath isEqualToString:@"collectionView.contentOffset"]) {
        CGFloat floatPage = self.collectionView.contentOffset.x / [self pageWidth];
        NSInteger newPage = round(floatPage);
        if (_currentPage != newPage) {
            _currentPage = newPage;
        }
    }
}

- (void)dealloc {
    @try {
        [self removeObserver:self forKeyPath:@"collectionView.contentOffset"];
    } @catch (NSException * exception) {
        
    }
}

@end
