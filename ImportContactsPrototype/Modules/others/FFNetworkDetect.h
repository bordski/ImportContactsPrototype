//
//  FFNetworkDetect.h
//  Flickflyer
//
//  Created by Adrich on 4/4/14.
//  Copyright (c) 2014 Brewedconcepts. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FFNetworkDetect : NSObject

+(unsigned int)ffnetworkConnectionType;
+ (NSString*)myIPAddress;

@end
