//
//  CheckInternet.m
//  MyClassAdriel
//
//  Created by Adriel Artiza on 5/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CheckInternet.h"
#import "Reachability.h"
#import "AppDelegate.h"
#define kInternet(notify)   [[NSNotificationCenter defaultCenter] postNotificationName:@"no-internet" object:nil];
//
//  Note: ARC disabled in this Module
//
//

@implementation CheckInternet

@synthesize checkNetActivity;

static CheckInternet *sharedNETinstance = nil;

#pragma mark -
#pragma mark NCESingleton Methods

// Get the shared instance and create it if necessary.
+(CheckInternet*)sharedCheckInternet {
    if (sharedNETinstance == nil) {
        sharedNETinstance = [[super allocWithZone:NULL] init];
    }
    return sharedNETinstance;
}

-(id)init
{
    self = [super init];
    
    if (self) {
        
        [self checkConnectivity];
    }
    
    return self;
}

-(void)dealloc
{
    // not called
    [super dealloc];
}

// don't allocate instance
+(id)allocWithZone:(NSZone*)zone {
    return [[self sharedCheckInternet] retain];
}

// don't generate multiple copies of the singleton.
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

// Do nothing, as we don't have a retain counter for this object.
- (id)retain {
    return self;
}

// Replace the retain counter so we can never release this object.
- (NSUInteger)retainCount {
    return NSUIntegerMax;
}

// Don't want to let the user release this object.
- (oneway void)release {
    
}

//Do nothing, autorelease.
- (id)autorelease {
    return self;
}



//Called by Reachability whenever status changes.
- (void) reachabilityChanged: (NSNotification* )note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
	
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"%s 0.NotReachable",__FUNCTION__);
            self.checkNetActivity = kAccessNotAvailable;
    
            NSString *notifInfo = @"NotReachable:[reachabilityChanged]";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"internetDisconnected" object:notifInfo];
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"1.ReachableViaWWAN");
            self.checkNetActivity = kChangeReachability;
            
            
            NSString *notifInfo = @"KreachabilityChanged";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"internetConnected" object:notifInfo];
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"2.ReachableViaWiFi");
            self.checkNetActivity = kChangeReachability;
            
            NSString *notifInfo = @"KreachabilityChanged";
            [[NSNotificationCenter defaultCenter] postNotificationName:@"internetConnected" object:notifInfo];
            
            
            
            break;
        }

    }
}


-(void)checkConnectivity
{

    NSLog(@"checkConnectivity");
    
    [[NSNotificationCenter defaultCenter] addObserver: self 
                                             selector: @selector(reachabilityChanged:) 
                                                 name: kReachabilityChangedNotification object: nil];
    
    internetReach = [[Reachability reachabilityForInternetConnection] retain];
	[internetReach startNotifier];
    
}

-(void)setToDidBecomeActive
{
    NetworkStatus netStatus = [internetReach currentReachabilityStatus];
    
    switch (netStatus)
    {
        case NotReachable:
        {
            NSLog(@"0.NotReachable");
            self.checkNetActivity = kAccessNotAvailable;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"no-internet" object:nil];
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"1.ReachableViaWWAN");
            self.checkNetActivity = kCheckReachability;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"2.ReachableViaWiFi");
            self.checkNetActivity = kCheckReachability;
            break;
        }
        
            
    }
}

-(CheckNetStatus)getReachabilityStatus
{
    return checkNetActivity;
}

-(void)checkInternetConnection
{
    [self checkConnectivity];
    [self setToDidBecomeActive];
    
    self.hasInternet = [self hasInternetConnection];
}

-(BOOL)hasInternetConnection
{
    if ([self getReachabilityStatus] != 0)
        return YES;
    else
        return NO;
}

@end
