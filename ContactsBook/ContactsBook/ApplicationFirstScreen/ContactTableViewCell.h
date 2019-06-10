//
//  ContactTableViewCell.h
//  ContactsBook
//
//  Created by Tatyana Shut on 8.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"


@class ContactTableViewCellDelegate;
@protocol ContactTableViewCellDelegate <NSObject>

- (void) showInfoControllerWithContact: (ContactInfo *)contact;
@end


@interface ContactTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *contactFullName;
@property (strong, nonatomic) IBOutlet UIButton *infoButton;
@property (strong, nonatomic) ContactInfo *contact;

@property (nonatomic, weak) id <ContactTableViewCellDelegate> delegate;

@end
