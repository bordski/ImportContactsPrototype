//
//  ContactListTableViewController.m
//  ImportContactsPrototype
//
//  Created by Michael Xernan Bordonada on 5/6/15.
//  Copyright (c) 2015 Michael Xernan Bordonada. All rights reserved.
//

#import <AddressBook/AddressBook.h>

#import "ContactListTableViewController.h"
#import "ContactModel.h"

@interface ContactListTableViewController () <UIAlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UITableView *tableView;

//alert variables
@property (nonatomic, strong) UIAlertView *alertMessageView;
@property (nonatomic, strong) NSString *alertMessage;

//temporary property variables
@property (nonatomic, strong) NSArray *dummyContacts;

//addressbook variables
@property (nonatomic, readonly) ABAddressBookRef addressbookReference;

//contacts variables
@property (nonatomic, strong) NSMutableArray *contactCollection;
@property (nonatomic, strong) NSMutableArray *filteredContactCollection;

//filter variables
@property (nonatomic, strong) NSString *filterString;
@property (nonatomic, strong) NSPredicate *filterPredicate;

@end

@implementation ContactListTableViewController

#pragma mark - Synthesizers

//alert variables
@synthesize alertMessageView = _alertMessageView;
@synthesize alertMessage = _alertMessage;

//temporary synthesize variable
@synthesize dummyContacts = _dummyContacts;

//addressbook variables
@synthesize addressbookReference = _addressbookReference;

//contacts variables
@synthesize contactCollection = _contactCollection;
@synthesize filteredContactCollection = _filteredContactCollection;

//filter variables
@synthesize filterString = _filterString;
@synthesize filterPredicate = _filterPredicate;

#pragma mark - Overridden Getters

- (UIAlertView *)alertMessageView {
    if (_alertMessageView == nil) {
        _alertMessageView = [[UIAlertView alloc] initWithTitle:@"Contact List" message:self.alertMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    
    return _alertMessageView;
}

//temporary getter
- (NSArray *)dummyContacts {
    if (_dummyContacts == nil) {
        _dummyContacts = @[@{@"firstname" : @"Michael Xernan",
                             @"lastname" : @"Bordonada"},
                           @{@"firstname" : @"Mar",
                             @"lastname" : @"Meija"},
                           @{@"email" : @[@"jerome@blumr.com"]},
                           @{@"email" : @[@"enzen@blumr.com"]},
                           @{@"email" : @[@"jobert@blumr.com"]},
                           @{@"mobilenumber" : @[@"09152229988", @"09178334444"]},
                           @{@"mobilenumber" : @[@"09178334422"]},
                           @{@"mobilenumber" : @[@"09191112222", @"09861234321", @"09155556666"]}];
        
    }
    
    return _dummyContacts;
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
    [self.tableView reloadData];
}

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestAddressbookPermission];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

#pragma mark - Memory Handlers

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Addressbook permission handlers

- (void)requestAddressbookPermission {
    @autoreleasepool {
        ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                if (granted == TRUE) {
                    [self createDummyData];
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

- (void)createContactUsingDictionary:(NSDictionary *)userInformation {
    
    if (userInformation == nil) {
        NSLog(@"%s user information dictionary cannot be nil", __PRETTY_FUNCTION__);
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        ABRecordRef person = ABPersonCreate();
        
        [userInformation enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
    
            ABPropertyID propertyTitle = 0;
            CFStringRef propertyLabel = NULL;
            if ([key isEqualToString:@"firstname"]) {
                propertyTitle = kABPersonFirstNameProperty;
            } else if ([key isEqualToString:@"lastname"]) {
                propertyTitle = kABPersonLastNameProperty;
            } else if ([key isEqualToString:@"email"]) {
                propertyTitle = kABPersonEmailProperty;
                propertyLabel = kABHomeLabel;
            } else if ([key isEqualToString:@"mobilenumber"]) {
                propertyTitle = kABPersonPhoneProperty;
                propertyLabel = kABPersonPhoneMobileLabel;
            }
            
            if ([obj isKindOfClass:[NSString class]]) {
                //this is of single value type string
                ABRecordSetValue(person, propertyTitle, (__bridge CFStringRef)obj, nil);
            } else if ([obj isKindOfClass:[NSArray class]]) {
                //this is of multivalue type array
                ABMutableMultiValueRef multiValueItem = ABMultiValueCreateMutable(kABMultiStringPropertyType);
                for (NSString *numberToInsert in (NSArray *)obj) {
                    ABMultiValueAddValueAndLabel(multiValueItem, (__bridge CFStringRef)numberToInsert, propertyLabel, NULL);
                }
                ABRecordSetValue(person, propertyTitle, multiValueItem, nil);
            } else {
                
            }
        }];
        dispatch_sync(dispatch_get_main_queue(), ^{
            ABAddressBookAddRecord(self.addressbookReference, person, nil);
            ABAddressBookSave(self.addressbookReference, nil);
        });
        
        
    });

}

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
                
                [self insertNewCellUsingValues:contact];
                
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
    contact.photoData = (__bridge NSData *)ABRecordCopyValue(rawContact, kABPersonImageFormatThumbnail);
    
    return contact;
}

#pragma mark - Prototype Data Sampling

- (void)createDummyData {
    
    [self.dummyContacts enumerateObjectsUsingBlock:^(NSDictionary *dummyData, NSUInteger idx, BOOL *stop) {
        [self createContactUsingDictionary:dummyData];
    }];
    
    [self fetchAndInsertContacsToArray:self.contactCollection];
}

#pragma mark - Alert view delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView == self.alertMessageView) {
        self.alertMessageView = nil;
    }
}

#pragma mark - Search bar delegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    self.filterString = searchText;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
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
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        } else if ([@[values] filteredArrayUsingPredicate:self.filterPredicate].count > 0) {
            [self.filteredContactCollection insertObject:values atIndex:nextIndex];
            [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    UIButton *availabilityCheckbox = (UIButton *)[cell viewWithTag:1];
    UILabel *availableContactTitle = (UILabel *)[cell viewWithTag:3];

    ContactModel *contact = self.filteredContactCollection[indexPath.row];
    availableContactTitle.text = contact.contactRepresentation;
    
    if (contact.isSelected == TRUE) {
        availabilityCheckbox.backgroundColor = [UIColor blueColor];
    } else {
        availabilityCheckbox.backgroundColor = [UIColor greenColor];
    }

    return cell;
}

- (void)didPressAvailabilityCheckbox:(NSIndexPath *)indexPath {
    ContactModel *contact = self.filteredContactCollection[indexPath.row];
    contact.isSelected = !contact.isSelected;
  
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self didPressAvailabilityCheckbox:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
