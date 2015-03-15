//
//  ViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 9/29/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "DemoViewController.h"
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
                            @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"}
                            ];
    _people = [[NSMutableArray alloc] init];
    
    for (NSDictionary *personDict in peopleData) {
        Person *aPerson = [[Person alloc] initWithDictionary:personDict];
        [_people addObject:aPerson];
    }
    
    //  The bigger the offset, the more you see on previous / next cards.
    
    
    UIOffset anOffset = UIOffsetZero;
    if (_layoutType == EBCardCollectionLayoutHorizontal) {
        self.title = @"Horizontal Scrolling";
        anOffset = UIOffsetMake(40, 10);
        [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutHorizontal];
    } else {
        self.title = @"Vertical Scrolling";
        anOffset = UIOffsetMake(20, 20);
        [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setOffset:anOffset];
        [(EBCardCollectionViewLayout *)_collectionView.collectionViewLayout setLayoutType:EBCardCollectionLayoutVertical];
    }
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

- (BOOL)shouldAutorotate {
    [_collectionView.collectionViewLayout invalidateLayout];
    
    BOOL retVal = YES;
    return retVal;
}

- (IBAction)addFirstButtonPressed:(id)sender {
    //  Create data object
    NSDictionary *newPersonDict = @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"};
    Person *newPerson = [[Person alloc] initWithDictionary:newPersonDict];
    
    //  Insert it on datasource
    [_people insertObject:newPerson atIndex:0];

    //  Add it on UICollectionView
    NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_collectionView insertItemsAtIndexPaths:@[newIndexPath]];
}

- (IBAction)addLastButtonPressed:(id)sender {
    //  Create data object
    NSDictionary *newPersonDict = @{@"name" : @"Ezequiel", @"twitter" : @"betzerra", @"avatarFilename" : @"betzerra.jpg"};
    Person *newPerson = [[Person alloc] initWithDictionary:newPersonDict];
    
    //  Insert it on datasource
    [_people addObject:newPerson];
    
    //  Add it on UICollectionView
    NSIndexPath* newIndexPath = [NSIndexPath indexPathForItem:[_people count]-1 inSection:0];
    [_collectionView insertItemsAtIndexPaths:@[newIndexPath]];
}

- (IBAction)removeFirstButtonPressed:(id)sender {
    [_people removeObjectAtIndex:0];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [_collectionView deleteItemsAtIndexPaths:@[newIndexPath]];
}

- (IBAction)removeLastButtonPressed:(id)sender {
    NSInteger indexToRemove = [_people count]-1;
    [_people removeObjectAtIndex:indexToRemove];
    NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:indexToRemove inSection:0];
    [_collectionView deleteItemsAtIndexPaths:@[newIndexPath]];
}
@end
