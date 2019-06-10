//
//  Section.m
//  ContactsBook
//
//  Created by Tatyana Shut on 9.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "SectionCell.h"

@implementation SectionCell

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *sectionView = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        [self.contentView addSubview:sectionView];
        sectionView.frame = self.contentView.bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)];
        [sectionView addGestureRecognizer:tap];
    }
    return self;
}
-(void)onTap:(UITapGestureRecognizer*)recognizer{
    
    if ([self.listener respondsToSelector:@selector(didTapOnHeader:)]){
        [self.listener didTapOnHeader:self];
    }
}

- (void)setExpanded:(BOOL)expanded {
   
        if (!expanded) {
            self.sectionLetter.textColor = [UIColor blackColor];
            self.contactsLabel.textColor = [UIColor colorWithRed:0x99/255.0f
                                                            green:0x9A/255.0f
                                                             blue:0x99/255.0f alpha:1];
            self.arrowImg.image = [UIImage imageNamed:@"arrow_down"];
        } else {
            self.sectionLetter.textColor = [UIColor colorWithRed:0.850 green:0.555 blue:0 alpha:1.0];
             self.contactsLabel.textColor = [UIColor colorWithRed:0.850 green:0.555 blue:0 alpha:1.0];
            self.arrowImg.image = [UIImage imageNamed:@"arrow_up"];
        }
    
}
@end
