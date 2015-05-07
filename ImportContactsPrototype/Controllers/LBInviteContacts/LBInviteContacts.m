//
//  LBInviteContacts.m
//  ImportContactsPrototype
//
//  Created by Michael Xernan Bordonada on 5/7/15.
//  Copyright (c) 2015 Michael Xernan Bordonada. All rights reserved.
//
#import <AddressBook/AddressBook.h>

#import "LBInviteContacts.h"
#import "LBInviteContactCell.h"
#import "ContactModel.h"
#import "MAInterface.h"
#import "BLConstant.h"
#import "LBIconFonts.h"



@interface LBInviteContacts () <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *iconf_check;
@property (weak, nonatomic) IBOutlet UILabel *iconf_search;

@property (nonatomic, strong) IBOutlet UITableView *tableView_list;

@property (weak, nonatomic) IBOutlet UITextField *textField_search;
@property (weak, nonatomic) IBOutlet UIButton *button_check;
@property (weak, nonatomic) IBOutlet UIButton *button_skip;
@property (weak, nonatomic) IBOutlet UIButton *button_proceed;

//alert variables
@property (nonatomic, strong) UIAlertView *alertMessageView;
@property (nonatomic, strong) NSString *alertMessage;

//addressbook variables
@property (nonatomic, readonly) ABAddressBookRef addressbookReference;

//contacts variables
@property (nonatomic, strong) NSMutableArray *contactCollection;
@property (nonatomic, strong) NSMutableArray *filteredContactCollection;

//filter variables
@property (nonatomic, strong) NSString *filterString;
@property (nonatomic, strong) NSPredicate *filterPredicate;

@end

@implementation LBInviteContacts

#pragma mark - Synthesizers

//alert variables
@synthesize alertMessageView = _alertMessageView;
@synthesize alertMessage = _alertMessage;

//addressbook variables
@synthesize addressbookReference = _addressbookReference;

//contacts variables
@synthesize contactCollection = _contactCollection;
@synthesize filteredContactCollection = _filteredContactCollection;

//filter variables
@synthesize filterString = _filterString;
@synthesize filterPredicate = _filterPredicate;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.button_check setSelected:TRUE];
    [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_on fontSize:26.0f];
    self.iconf_check.textColor = blumr_color_blue;
    [MAInterface convertToIconFont:self.iconf_search iconText:lb_blumrcon_search fontSize:26.0f];
    self.iconf_search.textColor = blumr_color_blue;
    [self requestAddressbookPermission];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Overridden Getters

- (UIAlertView *)alertMessageView {
    if (_alertMessageView == nil) {
        _alertMessageView = [[UIAlertView alloc] initWithTitle:@"Contact List" message:self.alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    
    return _alertMessageView;
}

//addressbook getters
- (ABAddressBookRef)addressbookReference {
    if (_addressbookReference == nil) {
        _addressbookReference = ABAddressBookCreateWithOptions(NULL, nil);
    }
    
    return _addressbookReference;
}

//contacts variables

- (NSMutableArray *)contactCollection {
    if (_contactCollection == nil) {
        _contactCollection = @[].mutableCopy;
    }
    
    return _contactCollection;
}

- (NSMutableArray *)filteredContactCollection {
    if (_filteredContactCollection == nil) {
        _filteredContactCollection = @[].mutableCopy;
    }
    
    return _filteredContactCollection;
}

//filter variables
- (NSString *)filterString {
    if (_filterString == nil) {
        _filterString = @"";
    }
    
    return _filterString;
}

- (NSPredicate *)filterPredicate {
    if (_filterPredicate == nil) {
        _filterPredicate = [NSPredicate predicateWithFormat:@"self.contactRepresentation CONTAINS[cd] %@", self.filterString];
    }
    
    return _filterPredicate;
}

#pragma mark - Overridden Setters

- (void)setAlertMessage:(NSString *)alertMessage {
    if (alertMessage == nil) {
        _alertMessage = @"";
    } else {
        _alertMessage = alertMessage;
    }
    
    [self.alertMessageView show];
}

- (void)setFilterString:(NSString *)filterString {
    if (filterString == nil) {
        NSLog(@"filter string cannot be nil");
        return;
    }
    
    self.filterPredicate = nil;
    
    _filterString = filterString;
    if ([filterString isEqualToString:@""] == TRUE) {
        [self.filteredContactCollection removeAllObjects];
        [self.filteredContactCollection addObjectsFromArray:self.contactCollection];
    } else {
        self.filteredContactCollection = [self.contactCollection filteredArrayUsingPredicate:self.filterPredicate].mutableCopy;
    }
    [self.tableView_list reloadData];
}

#pragma mark-
#pragma mark IBAction

- (IBAction)buttonProceed:(id)sender {
    NSArray *filteredSelectedContacts = [self getContactsWithSelectedValueOf:TRUE];
    NSLog(@"the selected contacts are:%@", [filteredSelectedContacts valueForKey:@"contactRepresentation"]);
    if (filteredSelectedContacts.count == 0) {
//#warning hadle alert
        self.alertMessage = @"Please select at least one contact";
    }
//    [self.delegate inviteContactsToOtherView:TRUE];
}

- (IBAction)buttonSkip:(id)sender {
//    [self.delegate inviteContactsToOtherView:FALSE];
}

- (IBAction)buttonCheckAll:(id)sender
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSArray *filteredContacts = [self getContactsWithSelectedValueOf:self.button_check.isSelected];
        if (filteredContacts.count == 0) {
            return;
        }
        
        [filteredContacts enumerateObjectsUsingBlock:^(ContactModel *contact, NSUInteger idx, BOOL *stop) {
            contact.isSelected = !self.button_check.isSelected;
        }];
    
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView_list reloadData];
            [self.button_check setSelected:!self.button_check.isSelected];
            if (self.button_check.isSelected == TRUE) {
                [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_on fontSize:26.0f];
            } else {
                [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_off fontSize:26.0f];
            }
            
        });
    });
}



#pragma mark - Addressbook permission handlers

- (void)requestAddressbookPermission {
    @autoreleasepool {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted == TRUE) {
                    //                    [self createDummyData];
                    [self fetchAndInsertContacsToArray:self.contactCollection];
                } else {
                    self.alertMessage = @"Application needs to access the addressbook in order for it to run properly, please allow access";
                }
            });
        });
    }
}

- (BOOL)getAddressbookCurrentPermission {
    if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
        ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
        //1
        NSLog(@"Denied");
        return FALSE;
    } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
        //2
        NSLog(@"Authorized");
        return TRUE;
    } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
        //3
        NSLog(@"Not determined");
        return FALSE;
    }
}

#pragma mark - Addressbook operations

- (void)fetchAndInsertContacsToArray:(NSMutableArray *)array {
    @autoreleasepool {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
            NSArray *rawContactCollection = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(self.addressbookReference);
            
            [rawContactCollection enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                ABRecordRef rawContact = (__bridge ABRecordRef)obj;
                
                ContactModel *contact = [self createContactModelUsingABRecordRef:rawContact];
                
                if ([contact.firstname isEqualToString:@""] == FALSE && [contact.lastname isEqualToString:@""] == FALSE) {
                    //has name
                    [self insertNewCellUsingValues:contact];
                } else if (contact.emailCollection.count > 0) {
                    //has email
                    [self insertNewCellUsingValues:contact];
                } else if (contact.numberCollection.count > 0) {
                    //has number
                    [self insertNewCellUsingValues:contact];
                }
                
            }];
        });
    }
}

#pragma mark - Model Creation handler

- (ContactModel *)createContactModelUsingABRecordRef:(ABRecordRef)rawContact {
    ContactModel *contact = [[ContactModel alloc] init];
    
    ABMutableMultiValueRef raweMail = ABRecordCopyValue(rawContact, kABPersonEmailProperty);
    ABMutableMultiValueRef rawMobilenumber = ABRecordCopyValue(rawContact, kABPersonPhoneProperty);
    
    contact.isSelected = TRUE;
    contact.contactID = [NSNumber numberWithInt:ABRecordGetRecordID(rawContact)];
    contact.firstname = (__bridge NSString *)ABRecordCopyValue(rawContact, kABPersonFirstNameProperty);
    contact.lastname = (__bridge NSString *)ABRecordCopyValue(rawContact, kABPersonLastNameProperty);
    contact.emailCollection = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(raweMail);
    contact.numberCollection = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(rawMobilenumber);
    NSString *base64PhotoString = (__bridge NSString *)ABRecordCopyValue(rawContact, kABPersonImageFormatThumbnail);
    if (base64PhotoString != nil) {
        contact.photoData = [[NSData alloc] initWithBase64EncodedString:base64PhotoString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    }
    return contact;
}

#pragma mark - Model Fetching Handlers

- (NSArray *)getContactsWithSelectedValueOf:(BOOL)selectedValue {
    NSPredicate *filterUncheckedContacts = [NSPredicate predicateWithFormat:@"SELF.isSelected == %d", selectedValue];
    NSArray *filteredContacts = [self.contactCollection filteredArrayUsingPredicate:filterUncheckedContacts];
    return filteredContacts;
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == self.alertMessageView) {
        self.alertMessageView = nil;
    }
}

#pragma mark - Text field delegate
// Close keyboard when Enter or Done is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self.textField_search resignFirstResponder];
    
    return NO;
}

// String in Search textfield
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring stringByReplacingCharactersInRange:range withString:string];

    self.filterString = substring;
    
    return YES;
}

#pragma mark - Table view data source

- (void)insertNewCellUsingValues:(ContactModel *)values {
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSUInteger nextIndex = self.filteredContactCollection.count;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:nextIndex inSection:0];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        
        NSPredicate *checkIfContactExists = [NSPredicate predicateWithFormat:@"SELF.contactID = %@", values.contactID];
        if ([self.contactCollection filteredArrayUsingPredicate:checkIfContactExists].count == 0) {
            [self.contactCollection insertObject:values atIndex:self.contactCollection.count];
        }
        
        if ([self.filteredContactCollection filteredArrayUsingPredicate:checkIfContactExists].count > 0) {
            
        } else if ([self.filterString isEqualToString:@""]) {
            [self.filteredContactCollection insertObject:values atIndex:nextIndex];
            [self.tableView_list insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if ([@[values] filteredArrayUsingPredicate:self.filterPredicate].count > 0) {
            [self.filteredContactCollection insertObject:values atIndex:nextIndex];
            [self.tableView_list insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        
    });
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.filteredContactCollection.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LBInviteContactCell *cell = (LBInviteContactCell *)[tableView dequeueReusableCellWithIdentifier:@"contactList" forIndexPath:indexPath];
    
    ContactModel *contact = self.filteredContactCollection[indexPath.row];
    cell.contactModel = contact;
    
    return cell;
}

- (void)didPressAvailabilityCheckbox:(NSIndexPath *)indexPath {
    ContactModel *contact = self.filteredContactCollection[indexPath.row];
    contact.isSelected = !contact.isSelected;
    
    if (contact.isSelected == FALSE) {
        [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_off fontSize:26.0f];
        [self.button_check setSelected:FALSE];
    } else {
        NSArray *filteredContacts = [self getContactsWithSelectedValueOf:FALSE];
        if (filteredContacts.count == 0) {
            [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_on fontSize:26.0f];
            [self.button_check setSelected:TRUE];
        }
    }
    [self.tableView_list reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self didPressAvailabilityCheckbox:indexPath];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
