//
//  LBUserData.m
//  LBProject
//
//  Created by Adrich on 8/26/14.
//  Copyright (c) 2014 Blumoon. All rights reserved.
//

#import "LBUserData.h"

@implementation LBUserData

+(void)clearDataObjectforKey:(NSString*)aKey
{
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    [ffUserDefaults removeObjectForKey:aKey];
    if (ffUserDefaults) {
        [ffUserDefaults synchronize];
    }
}

+(void)setAppString:(NSString*)aStr forKey:(NSString*)key
{
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (ffUserDefaults)
    {
        //[LBUserData clearDataObjectforKey:key];
        [ffUserDefaults setObject:aStr forKey:key];
        [ffUserDefaults synchronize];
    }
}

+(NSString*)getAppString:(NSString*)key
{
    NSString *tmpUserName = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (tmpUserName == nil)
    {
        NSLog(@"%s NIL",__FUNCTION__);
        return nil;
    }
    else
    {
        return tmpUserName;
    }
}


+(void)setDataString:(NSString*)aStr forKey:(NSString*)key
{
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (ffUserDefaults) {
        //[LBUserData clearDataObjectforKey:key];
        [ffUserDefaults setObject:aStr forKey:key];
        [ffUserDefaults synchronize];
    }
}

+(NSString*)getDataSystemString:(NSString*)key
{
    NSString *tmpUserName = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (tmpUserName == nil)
    {
        NSLog(@"%s NIL",__FUNCTION__);
        return @"";
    }
    else
    {
        return tmpUserName;
    }
}


+(NSString*)getDataString:(NSString*)key
{
    NSString *tmpUserName = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    if (tmpUserName == nil)
    {
        NSLog(@"%s NIL",__FUNCTION__);
        return nil;
    }
    else
    {
        return tmpUserName;
    }
}


// Login/Logout
+(void)setLogin:(NSString*)aStr forKey:(NSString*)key
{
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    
    if (ffUserDefaults) {
        //[LBUserData clearDataObjectforKey:key];
        [ffUserDefaults setObject:aStr forKey:key];
        [ffUserDefaults synchronize];
    }
}

+(NSString*)getLogin:(NSString*)key
{
    NSString *tmpStr = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (tmpStr == nil) {
        NSLog(@"%s NIL",__FUNCTION__);
        return nil;//@"";
    }else{
        return tmpStr;
    }
}


+(void)setJSONDataToArray:(NSMutableArray*)ads forKey:(NSString*)aKey
{
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    NSData *myEncodedObject = [FFArchiver archivedDataWithRootObject:ads];
    
    [ffUserDefaults removeObjectForKey:aKey];
    if (ffUserDefaults) {
        //[LBUserData clearDataObjectforKey:aKey];
        [ffUserDefaults setObject:myEncodedObject forKey:aKey];
        [ffUserDefaults synchronize];
    }
}

+(NSMutableArray*)getAdsJSONData:(NSString*)aKey
{
    NSMutableArray *adsFromArray = nil;
    NSUserDefaults *ffUserDefaults = [NSUserDefaults standardUserDefaults];
    NSData *adsObject = [ffUserDefaults objectForKey:aKey];
    if (adsObject == nil) {
        NSLog(@"%s NIL",__FUNCTION__);
        return nil;
    }else{
        adsFromArray = [FFUnArchiver unarchiveObjectWithData:adsObject];
        return adsFromArray;
    }
}


@end
