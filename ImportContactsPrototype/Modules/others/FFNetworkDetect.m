//
//  FFNetworkDetect.m
//  Flickflyer
//
//  Created by Adrich on 4/4/14.
//  Copyright (c) 2014 Brewedconcepts. All rights reserved.
//

#import "FFNetworkDetect.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <net/if.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

#define pkURL   "www.apple.com"

typedef NS_ENUM(NSUInteger, LBNetworkTypes) {
    NONETWORK,
    MOBILE3GNETWORK,
    WIFINETWORK
};

@implementation FFNetworkDetect

+(unsigned int)ffnetworkConnectionType
{
    const char *hostname = pkURL;
    SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, hostname);
    
    SCNetworkReachabilityFlags flags;
    SCNetworkReachabilityGetFlags(reachabilityRef, &flags);
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    if(isReachable && !needsConnection)
    {
        BOOL isCellularConnection = ((flags & kSCNetworkReachabilityFlagsIsWWAN) != 0);
        if(isCellularConnection)
            return MOBILE3GNETWORK;
        else
            return WIFINETWORK;
    }
    
    CFRelease(reachabilityRef);
    
    return NONETWORK;
}



+ (NSString*)myIPAddress
{
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

@end
