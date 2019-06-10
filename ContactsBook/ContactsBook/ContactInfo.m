//
//  ContactInfo.m
//  ContactsBook
//
//  Created by Tatyana Shut on 8.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "ContactInfo.h"


@implementation ContactInfo
- (instancetype)init
{
    self = [super init];
    if (self) {
        _contactMobilePhone = [[NSMutableArray alloc] init];
    }
    return self;
}
@end
