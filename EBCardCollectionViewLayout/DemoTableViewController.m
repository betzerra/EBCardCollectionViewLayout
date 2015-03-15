//
//  DemoTableViewController.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel Becerra on 3/15/15.
//  Copyright (c) 2015 Ezequiel A Becerra. All rights reserved.
//

#import "DemoTableViewController.h"
#import "DemoViewController.h"

@implementation DemoTableViewController

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"horizontalSegue"]) {
        DemoViewController *vc = (DemoViewController *)segue.destinationViewController;
        vc.layoutType = EBCardCollectionLayoutHorizontal;
        
    } else if ([segue.identifier isEqualToString:@"verticalSegue"]) {
        DemoViewController *vc = (DemoViewController *)segue.destinationViewController;
        vc.layoutType = EBCardCollectionLayoutVertical;
    }
}

@end
