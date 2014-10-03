//
//  EBCardCollectionViewCell.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "EBCardCollectionViewCell.h"

#define kHorizontalOffset 10

@implementation EBCardCollectionViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    
    float randomRed = arc4random() % 255 / 255.0;
    float randomGreen  = arc4random() % 255 / 255.0;
    float randomBlue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1];
    
    self.backgroundColor = randomColor;
}

@end
