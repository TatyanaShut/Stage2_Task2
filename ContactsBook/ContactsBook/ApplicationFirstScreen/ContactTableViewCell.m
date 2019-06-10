//
// ContactTableViewCell.m

//  ContactsBook
//
//  Created by Tatyana Shut on 8.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//
#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *view =[[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0xFE/255.0f
                                           green:0xF6/255.0f
                                            blue:0xE6/255.0f alpha:1];
    self.selectedBackgroundView = view;
    UITapGestureRecognizer *tap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleInfoIconTap:)];
    [self.infoButton addGestureRecognizer:tap];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (void)handleInfoIconTap:(UITapGestureRecognizer *)recognizer {
    [self.delegate showInfoControllerWithContact:self.contact];
}
@end
