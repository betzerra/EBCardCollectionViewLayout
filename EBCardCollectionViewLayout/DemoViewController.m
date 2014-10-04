//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "DemoViewController.h"
#import "EBCardCollectionViewLayout.h"
#import "DemoCollectionViewCell.h"

@interface DemoViewController ()

@end

@implementation DemoViewController

#pragma mark - Public

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *peopleData = @[@{@"name" : @"Dexter Pinkman", @"twitter" : @"loboscator", @"avatarFilename" : @"loboscator.jpg"},
                            @{@"name" : @"Asgardian Squirrel", @"twitter" : @"pepper__potts", @"avatarFilename" : @"pepperpotts.jpg"},
                            @{@"name" : @"HeronswayDreamWeaver", @"twitter" : @"nieblah", @"avatarFilename" : @"nieblah.jpg"},
                            @{@"name" : @"F", @"twitter" : @"vestidofloreado", @"avatarFilename" : @"f.jpg"},
                            @{@"name" : @"Morán", @"twitter" : @"fernandomoran", @"avatarFilename" : @"fernandomoran.jpg"},
                            @{@"name" : @"SweetN'Sour Carolain", @"twitter" : @"aCarolain", @"avatarFilename" : @"acarolain.jpg"},
                            @{@"name" : @"Joaquin Casarini", @"twitter" : @"jcasarini", @"avatarFilename" : @"jcasarini.jpg"},
                            @{@"name" : @"Gastón Oliva", @"twitter" : @"gastonoliva", @"avatarFilename" : @"gastonoliva.jpg"},
                            @{@"name" : @"Anita Baggiano", @"twitter" : @"anitabagg", @"avatarFilename" : @"anitabagg.jpg"},
                            @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"},];
    _people = [[NSMutableArray alloc] init];
    
    for (NSDictionary *personDict in peopleData) {
        Person *aPerson = [[Person alloc] initWithDictionary:personDict];
        [_people addObject:aPerson];
    }
    
    //  The bigger the offset, the more you see on previous / next cards.
    UIOffset anOffset = UIOffsetMake(40, 10);
    [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_people count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCollectionViewCell *retVal = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell"
                                                                              forIndexPath:indexPath];
    retVal.person = _people[indexPath.row];
    return retVal;
}

@end
