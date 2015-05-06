//
//  ContactModel.m
//  ImportContactsPrototype
//
//  Created by Michael Xernan Bordonada on 5/6/15.
//  Copyright (c) 2015 Michael Xernan Bordonada. All rights reserved.
//

#import "ContactModel.h"

@implementation ContactModel

#pragma mark - Public Synthesizers
//selection variables
@synthesize isSelected = _isSelected;

//contact information variables
@synthesize contactID = _contactID;
@synthesize firstname = _firstname;
@synthesize lastname = _lastname;
@synthesize emailCollection = _emailCollection;
@synthesize numberCollection = _numberCollection;

@synthesize photoData = _photoData;

@synthesize contactRepresentation = _contactRepresentation;

#pragma mark - Overridden Getter

- (NSNumber *)contactID {
    if (_contactID == nil) {
        _contactID = @0;
    }
    
    return _contactID;
}

- (NSString *)firstname {
    if (_firstname == nil) {
        _firstname = @"";
    }
    return _firstname;
}

- (NSString *)lastname {
    if (_lastname == nil) {
        _lastname = @"";
    }
    return _lastname;
}

- (NSArray *)emailCollection {
    if (_emailCollection == nil) {
        _emailCollection = @[];
    }
    
    return _emailCollection;
}

- (NSArray *)numberCollection {
    if (_numberCollection == nil) {
        _numberCollection = @[];
    }
    return _numberCollection;
}

- (NSData *)photoData {
    if (_photoData == nil) {
        _photoData = [NSData data];
    }
    
    return _photoData;
}

- (NSString *)contactRepresentation {
    if (_contactRepresentation == nil) {
        if ([self.firstname isEqualToString:@""] == FALSE && [self.lastname isEqualToString:@""] == FALSE) {
            //has name
            _contactRepresentation = [NSString stringWithFormat:@"%@ %@", self.firstname, self.lastname];
        } else if (self.emailCollection.count > 0) {
            //has email
            _contactRepresentation = self.emailCollection[0];
        } else if (self.numberCollection.count > 0) {
            //has number
            _contactRepresentation = self.numberCollection[0];
        }
    }
    
    return _contactRepresentation;
}

#pragma mark - Overridden Setter

@end
