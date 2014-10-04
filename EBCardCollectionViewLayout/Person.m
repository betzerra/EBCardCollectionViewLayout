//
//  Person.m
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 10/4/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import "Person.h"

@implementation Person

#pragma mark - Properties

- (NSString *)twitter {
    NSString *retVal = [NSString stringWithFormat:@"@%@", _twitter];
    return retVal;
}

#pragma mark - Public

- (instancetype) initWithDictionary:(NSDictionary *)aDictionary {
    self = [self init];
    if (self) {
        self.name = aDictionary[@"name"];
        self.twitter = aDictionary[@"twitter"];
        self.avatarFilename = aDictionary[@"avatarFilename"];
    }
    return self;
}

@end
