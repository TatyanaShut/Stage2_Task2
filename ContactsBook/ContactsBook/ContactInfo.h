//
//  Contact.h
//  ContactsBook
//
//  Created by Tatyana Shut on 8.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ContactInfo : NSObject
@property(nonatomic, strong) NSString *contactFirstName;
@property(nonatomic, strong)NSString *contactLastName;
@property (nonatomic, strong) UIImage *contactImage;
@property (nonatomic, strong) NSMutableArray *contactMobilePhone;
@end
