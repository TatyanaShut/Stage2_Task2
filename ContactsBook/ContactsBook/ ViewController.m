//
//  ViewController.m
//  ContactsBook
//
//  Created by Tatyana Shut on 8.06.2019.
//  Copyright © 2019 Tatyana Shut. All rights reserved.
//

#import "ViewController.h"
#import "ContactInfo.h"
#import "ContactTableViewCell.h"
#import "ContactDetailViewController.h"
#import "SectionCell.h"
#import <Contacts/Contacts.h>


NSString *const regexEnglish = @"[a-zA-Z]";
NSString *const regexRussia = @"[\a-zA-Z0-9!#$%&'*+-/=?^_`{|}~><,.]";

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DemoHeaderViewListener,ContactTableViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *contactsArray;
@property (strong, nonatomic) NSMutableArray *titleArraySection;
@property (strong, nonatomic) NSMutableArray *expandedArray;
@property (strong, nonatomic) NSMutableDictionary *mainDictionary;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Контакты";
    self.contactsArray = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ContactTableViewCell"];
    [self.view addSubview:self.tableView];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self mainArrayContact];
    self.expandedArray = [[NSMutableArray alloc] init];
    self.titleArraySection = [[NSMutableArray alloc] init];
    self.titleArraySection = [self arrayOfSections];
    [self.tableView registerClass:[SectionCell class] forHeaderFooterViewReuseIdentifier:@"sectionId"];
    
    self.navigationController.navigationBar.layer.borderColor = [UIColor colorWithRed:0xE6/255.0f
                                                                                green:0xE6/255.0f
                                                                                 blue:0xE6/255.0f alpha:1].CGColor;
    if (@available(iOS 11.0, *)) {
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
                                                  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
                                                  [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                                  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
                                                  ]
         ];
    } else {
        [NSLayoutConstraint activateConstraints:@[
                                                  [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                                  [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                                  [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                                  [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
                                                  ]
         ];
    }
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    UINib *nibb = [UINib nibWithNibName:@"ContactTableViewCell" bundle:nil];
    [self.tableView registerNib:nibb forCellReuseIdentifier:@"ContactTableViewCell"];
    
    for(NSInteger i=0; i< self.titleArraySection.count; i++){
        [self.expandedArray addObject:@NO];
    }
    
    self.mainDictionary = [[NSMutableDictionary alloc]init];
    for(NSString *key in  self.titleArraySection ){
        for(ContactInfo *i in self.contactsArray){
            if([key isEqualToString:[i.contactLastName substringToIndex:1]]){
                if ([_mainDictionary objectForKey:key] == nil )
                {
                    [_mainDictionary setObject:[NSMutableArray new] forKey:key];
                    [[_mainDictionary objectForKey:key] addObject:i];
                }
                
                else
                    [[_mainDictionary objectForKey:key] addObject:i];
            }
        }
    }
    
}

-(NSMutableArray*)arrayOfSections{
    NSMutableSet *setTitleSectionEnglish = [[NSMutableSet alloc] init];
    NSMutableSet *setTitleSectionEnglishRussian = [[NSMutableSet alloc] init];
    
    BOOL resultEnglish = NO;
    BOOL resultRussia = NO;
    for(ContactInfo *contact in self.contactsArray){
        NSString *letter = [contact.contactLastName substringToIndex:1];
        NSPredicate *testEnglish = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexEnglish];
        NSPredicate *testRussia = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexRussia];
        resultEnglish = [testEnglish evaluateWithObject:letter];
        resultEnglish = [testRussia evaluateWithObject:letter];
        if(resultEnglish)
        {
            [setTitleSectionEnglish addObject:letter];
        }
        else {
            if(resultRussia)
            {
                [setTitleSectionEnglishRussian addObject: letter];
            }
            
        }
    }
    NSArray *arrayEnglish = [[NSArray alloc] initWithArray:[setTitleSectionEnglish allObjects]];
    NSArray *arrayRussian= [[NSArray alloc] initWithArray:[setTitleSectionEnglishRussian allObjects]];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"description" ascending:YES];
    arrayEnglish = [setTitleSectionEnglish sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
    NSArray *newArray=arrayRussian?[arrayRussian arrayByAddingObjectsFromArray:arrayEnglish]:[[NSArray alloc] initWithArray:arrayEnglish];
    NSMutableArray *mainArray=[[NSMutableArray alloc] initWithArray:newArray];
    if (resultEnglish == NO  &&  regexRussia == NO)
        [mainArray addObject:@"#"];
    return mainArray;
}


-(void)mainArrayContact{
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted == YES) {
            
            NSArray *contactArray = @[CNContactFamilyNameKey, CNContactGivenNameKey, CNContactPhoneNumbersKey, CNContactImageDataKey,CNContactImageDataAvailableKey,CNContactThumbnailImageDataKey ];
            CNContactFetchRequest *contactTetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:contactArray];
            
            [contactStore enumerateContactsWithFetchRequest:contactTetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                ContactInfo *newContact = [[ContactInfo alloc] init];
                newContact.contactFirstName = contact.givenName;
                newContact.contactLastName = contact.familyName;
                
                UIImage *image = [[UIImage alloc] initWithData:contact.imageData];
                newContact.contactImage = image;
                for (CNLabeledValue *val in contact.phoneNumbers){
                    NSString *phone = [val.value stringValue];
                    if([phone length]>0){
                        [newContact.contactMobilePhone addObject:phone];
                    }
                }
                
                [self.contactsArray addObject:newContact];
            }];
        }
        else
        {
            self.tableView.hidden = YES;
            self.view.backgroundColor = [UIColor grayColor];
            UILabel *warningLabel = [UILabel new];
            warningLabel.textColor = [UIColor blackColor];
            warningLabel.font = [UIFont systemFontOfSize:17 weight:UIFontWeightRegular];
            warningLabel.textColor = [UIColor blackColor];
            warningLabel.text = @"Доступ к списку контактов запрещен. Войдите в Settings и разрешите доступ.";
            warningLabel.numberOfLines = 0;
            warningLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:warningLabel];
            warningLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [NSLayoutConstraint activateConstraints:@[
                                                      [warningLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:50],
                                                      [warningLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-50],
                                                      [warningLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]
                                                      ]];
        }
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark - DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArraySection.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.expandedArray[section] boolValue])
    {
        return 0;
    }
    else{
        
        return [[self.mainDictionary objectForKey:[self.titleArraySection objectAtIndex:section]] count];
    };
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactTableViewCell *cell = (ContactTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:@"ContactTableViewCell" forIndexPath:indexPath];
        if(cell == nil) {
            cell = (ContactTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"ContactTableViewCell"];
    
        }
    
    NSArray *sectionContacts = [self.mainDictionary objectForKey:[self.titleArraySection objectAtIndex:indexPath.section]];
    ContactInfo *contact = [sectionContacts objectAtIndex:indexPath.row];
    
    cell.contact= contact;
    cell.delegate = self;
    cell.contactFullName.text = [NSString stringWithFormat:@"%@ %@", contact.contactFirstName, contact.contactLastName];
    return cell;
}



#pragma mark -Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *sectionTitle = [self.titleArraySection objectAtIndex:indexPath.section];
    NSArray *section = [self.mainDictionary objectForKey:sectionTitle];
    ContactInfo *contact = [section objectAtIndex:indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert" message:[NSString stringWithFormat:@"Контакт %@ %@, номер телефона %@", contact.contactFirstName, contact.contactLastName, contact.contactMobilePhone.count > 0 ? contact.contactMobilePhone[0] : @"Отсутствует"] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    SectionCell *titleSection = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"sectionId"];
    NSString *letter = [self.titleArraySection objectAtIndex:section];
    NSString *numberOfContacts = [NSString stringWithFormat:@"контактов: %ld", (long)[[self.mainDictionary objectForKey:letter]count]];
    titleSection.sectionLetter.text = letter;
    titleSection.contactsLabel.text= numberOfContacts;
    titleSection.expanded = [self.expandedArray[section] boolValue];
    titleSection.section = section;
    titleSection.listener = self;
    return titleSection;
}

- (UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath  API_AVAILABLE(ios(11.0)){
    UIContextualAction *deleteAction = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive title:@"Delete" handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
        NSString *sectionTitle = [self.titleArraySection objectAtIndex:indexPath.section];
        [ [self.mainDictionary objectForKey:sectionTitle]removeObjectAtIndex:indexPath.row];
        if([[self.mainDictionary objectForKey:sectionTitle] count ]==0)
            [self.titleArraySection removeObject:sectionTitle];
        
        [self.tableView reloadData];
    }];
    
    UISwipeActionsConfiguration *configuraion = [UISwipeActionsConfiguration configurationWithActions:@[deleteAction]];
    configuraion.performsFirstActionWithFullSwipe = NO;
    return configuraion;
}



#pragma mark - DemoHeaderView
- (void)didTapOnHeader:(SectionCell *)header{
    
    BOOL state = [self.expandedArray[header.section] boolValue];
    self.expandedArray[header.section] = @(!state);
    header.expanded = !state;
    if (state) {
        NSMutableArray *paths = [NSMutableArray array];
        NSInteger a = [[self.mainDictionary valueForKey:[self.titleArraySection objectAtIndex:header.section]]count ];
        for (NSInteger i =0; i<a; i++) {
            NSIndexPath *path =[NSIndexPath indexPathForRow:i inSection:header.section];
            [paths addObject:path];
        }
        
        [self.tableView insertRowsAtIndexPaths:paths  withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else{
        NSMutableArray *paths = [NSMutableArray array];
        NSInteger a = [[self.mainDictionary valueForKey:[self.titleArraySection objectAtIndex:header.section]]count ];
        for (NSInteger i =0; i<a; i++) {
            NSIndexPath *path =[NSIndexPath indexPathForRow:i inSection:header.section];
            [paths addObject:path];
        }
        [self.tableView deleteRowsAtIndexPaths:paths withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
}


#pragma mark - ContactTableViewCellDelegate

-(void)showInfoControllerWithContact:(ContactInfo *)contact {
    ContactDetailViewController *vc = [[ContactDetailViewController alloc] initWithNibName:@"ContactDetailViewController" bundle:nil];
    vc.contact = contact;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
