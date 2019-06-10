//
//  ContactDetailViewController.h
//  ContactsBook
//
//  Created by Tatyana Shut on 10.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ContactDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;
@property (weak, nonatomic) IBOutlet UILabel *contactFullName;
@property (nonatomic, strong) ContactInfo *contact;
@end

NS_ASSUME_NONNULL_END
