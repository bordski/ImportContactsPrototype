//
//  UserData.h
//  Blumr
//
//  Created by Adrich on 1/14/15.
//  Copyright (c) 2015 Let's Blum It!. All rights reserved.
//

#import "UserData.h"

@implementation UserData


+(UserData*)sharedData
{
    static UserData *sharedData = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedData = [[self alloc] init];
    });
    
    return sharedData;
}

- (id)init {
    if (self = [super init]) {
        
        // Initialize value here . . .
    
    }
    return self;
}

- (void)dealloc {
    // To clarify here ( dealloc )
}


@end
