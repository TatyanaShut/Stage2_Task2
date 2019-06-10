//
//  Section.h
//  ContactsBook
//
//  Created by Tatyana Shut on 9.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SectionCell;
@protocol DemoHeaderViewListener <NSObject>

-(void)didTapOnHeader:(SectionCell*)header;

@end


@interface SectionCell : UITableViewHeaderFooterView
@property (assign, nonatomic) BOOL expanded;
@property (nonatomic,weak) id<DemoHeaderViewListener> listener;
@property (nonatomic,assign)NSInteger section;
@property (nonatomic,strong)UITapGestureRecognizer *taprecognizer;
@property (strong, nonatomic) IBOutlet UILabel *sectionLetter;
@property (strong, nonatomic) IBOutlet UILabel *contactsLabel;
@property (strong, nonatomic) IBOutlet UIImageView *arrowImg;


@end


