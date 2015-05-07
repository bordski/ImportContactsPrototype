//
//  CheckInternet.h
//  MyClassAdriel
//
//  Created by Adriel Artiza on 5/13/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <netinet/in.h>

typedef enum{kAccessNotAvailable,kChangeReachability,kCheckReachability}CheckNetStatus;

@class Reachability;
@interface CheckInternet : NSObject
{
    @private
    Reachability *internetReach;
    CheckNetStatus checkNetActivity;
    
}

@property(assign) CheckNetStatus checkNetActivity;
@property(assign) BOOL hasInternet;

+(id)sharedCheckInternet;

-(void)reachabilityChanged:(NSNotification*)note;
-(void)checkConnectivity;
-(void)setToDidBecomeActive;
-(void)checkInternetConnection;
-(BOOL)hasInternetConnection;
-(CheckNetStatus)getReachabilityStatus;

@end
