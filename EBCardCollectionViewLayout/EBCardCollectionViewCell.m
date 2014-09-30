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
    
    self.backgroundColor = [UIColor clearColor];
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:backgroundView];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1
                                                                       constant:kHorizontalOffset];
    
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1
                                                                        constant:-kHorizontalOffset];
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1
                                                                      constant:0];
    
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:backgroundView
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1
                                                                         constant:0];
    
    NSArray *constraints = @[leftConstraint, rightConstraint, topConstraint, bottomConstraint];
    [self addConstraints:constraints];
    
    float randomRed = arc4random() % 255 / 255.0;
    float randomGreen  = arc4random() % 255 / 255.0;
    float randomBlue = arc4random() % 255 / 255.0;
    UIColor *randomColor = [UIColor colorWithRed:randomRed green:randomGreen blue:randomBlue alpha:1];
    
    backgroundView.backgroundColor = randomColor;
}

@end
