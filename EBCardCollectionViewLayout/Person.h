//
//  Person.h
//  EBCardCollectionViewLayout
//
//  Created by Ezequiel A Becerra on 10/4/14.
//  Copyright (c) 2014 Ezequiel A Becerra. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

- (instancetype) initWithDictionary:(NSDictionary *)aDictionary;

@property (strong) NSString *name;
@property (strong, nonatomic) NSString *twitter;
@property (strong) NSString *avatarFilename;
@end
