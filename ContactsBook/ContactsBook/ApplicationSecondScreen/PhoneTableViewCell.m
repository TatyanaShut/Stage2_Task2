//
//  PhoneTableViewCell.m
//  ContactNameBook
//
//  Created by Tatyana Shut on 10.06.2019.
//  Copyright © 2019 Иван. All rights reserved.
//

#import "PhoneTableViewCell.h"

@implementation PhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.numberPhoneLabel = [[UILabel alloc]init];
        [self addSubview:self.numberPhoneLabel];
        self.numberPhoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
        
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.numberPhoneLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20],
                                                  [self.numberPhoneLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20],
                                                  [self.numberPhoneLabel.heightAnchor constraintEqualToConstant:44],
                                                  [self.numberPhoneLabel.centerYAnchor constraintEqualToAnchor:self.centerYAnchor]
                                                  ]
         ];
    }
    return self;
}

@end
