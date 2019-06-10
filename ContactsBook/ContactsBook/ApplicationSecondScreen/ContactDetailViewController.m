//
//  ContactDetailViewController.m
//  ContactsBook
//
//  Created by Tatyana Shut on 10.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//
#import "ContactDetailViewController.h"
#import "PhoneTableViewCell.h"

@interface ContactDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ContactDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.contact.contactImage) {
        self.contactImage.image = self.contact.contactImage;
        self.contactImage.contentMode = UIViewContentModeScaleAspectFill;
        self.contactImage.layer.cornerRadius = self.contactImage.frame.size.width / 2;
        self.contactImage.clipsToBounds = YES;
    }
    else {
        self.contactImage.image = [UIImage imageNamed:@"noPhoto"];
    }
    
    self.contactFullName.text = [NSString stringWithFormat:@"%@ %@", self.contact.contactFirstName, self.contact.contactLastName];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[PhoneTableViewCell class] forCellReuseIdentifier:@"PhoneTableViewCell"];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    
    self.tableView.tableFooterView = [UIView new];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backButtonnImage = [UIImage imageNamed:@"arrow_left"];
    [backButton setBackgroundImage:backButtonnImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton] ;
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contact.contactMobilePhone.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"PhoneTableViewCell";
    
    PhoneTableViewCell *cell = (PhoneTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = (PhoneTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
    }
    
    cell.numberPhoneLabel.text = self.contact.contactMobilePhone[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
