//
//  LBUserData.h
//  LBProject
//
//  Created by Adrich on 8/26/14.
//  Copyright (c) 2014 Blumoon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FFArchiver      NSKeyedArchiver
#define FFUnArchiver    NSKeyedUnarchiver

@interface LBUserData : NSObject

+(void)clearDataObjectforKey:(NSString*)aKey;

// *** Use for fresh install app ( currently use in sign-in/up [ #DEFINE ] ) ***
+(NSString*)getAppString:(NSString*)key;
+(void)setAppString:(NSString*)aStr forKey:(NSString*)key;

// *** Global object set ***
+(void)setDataString:(NSString*)aStr forKey:(NSString*)key;
+(NSString*)getDataString:(NSString*)key;

// *** Use in jrr, Slave and treat ***
+(NSString*)getDataSystemString:(NSString*)key;

// *** Use for Sign-in and Sign-up data ***
+(void)setLogin:(NSString*)aStr forKey:(NSString*)key;
+(NSString*)getLogin:(NSString*)key;

+(void)setJSONDataToArray:(NSMutableArray*)ads forKey:(NSString*)aKey;
+(NSMutableArray*)getAdsJSONData:(NSString*)aKey;

@end
