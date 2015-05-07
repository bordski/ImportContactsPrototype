//
//  UserData.h
//  Blumr
//
//  Created by Adrich on 1/14/15.
//  Copyright (c) 2015 Let's Blum It!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UserData : NSObject

@property (nonatomic, assign) BOOL isTrend;

@property (nonatomic, assign) BOOL webSocketLogin;

@property (nonatomic, assign) BOOL easySignUp_traditional;
@property (nonatomic, strong) NSString *easySigUp_email_mobile;
@property (nonatomic, strong) NSString *signUp_username_use;
@property (nonatomic, assign) NSUInteger signUp_Using;

@property (nonatomic, assign) BOOL userAddNewComment;

// *** User data from TRADITIONAL SIGN-UP ***
@property (nonatomic, assign) BOOL isUserUpdate;
@property (nonatomic, strong) UIImage *avatar_image;
@property (nonatomic, strong) NSString *user_token;
@property (nonatomic, retain) NSString *user_first_name;
@property (nonatomic, retain) NSString *user_last_name;
@property (nonatomic, retain) NSString *user_middle_name;
@property (nonatomic, retain) NSString *user_full_name;
@property (nonatomic, retain) NSString *user_username;
@property (nonatomic, retain) NSString *user_avatar;
@property (nonatomic, retain) NSString *user_address;
@property (nonatomic, retain) NSString *user_postal;
@property (nonatomic, retain) NSString *user_availability;

@property (nonatomic, retain) NSString *user_email;
@property (nonatomic, retain) NSString *user_percent;
@property (nonatomic, assign) unsigned int user_on_off_line_status;
@property (nonatomic, retain) NSString *user_status_message;
@property (nonatomic, retain) NSString *user_country;
@property (nonatomic, retain) NSString *user_city;
@property (nonatomic, retain) NSString *user_phone_number;
@property (nonatomic, retain) NSString *user_gender;
@property (nonatomic, retain) NSString *user_image_avatar_url;
@property (nonatomic, strong) id user_profile_image;
@property (nonatomic, retain) NSString *blumr_since;

@property (nonatomic, retain) NSString *user_birth_day;
@property (nonatomic, retain) NSString *user_birth_month;
@property (nonatomic, retain) NSString *user_birth_year;

@property (nonatomic, retain) NSString *user_mobile;
@property (nonatomic, retain) NSString *user_additional_email;

// *** User data from [ FACEBOOK MOBILE ] ( GET INFO MOBILE PHONE ) ***
@property (nonatomic, strong) NSDictionary *fbPhone_facebook_me;
@property (nonatomic, strong) NSString *fbPhone_access_token;
@property (nonatomic, strong) NSString *fbPhone_birthday;
@property (nonatomic, strong) NSString *fbPhone_email;
@property (nonatomic, strong) NSString *fbPhone_first_name;
@property (nonatomic, strong) NSString *fbPhone_gender;
@property (nonatomic, strong) NSString *fbPhone_id;
@property (nonatomic, strong) NSString *fbPhone_last_name;
@property (nonatomic, strong) NSString *fbPhone_link;
@property (nonatomic, strong) NSString *fbPhone_locale;
@property (nonatomic, strong) NSDictionary *fbPhone_location;
@property (nonatomic, strong) NSString *fbPhone_name;
@property (nonatomic, strong) NSString *fbPhone_updated_time;
@property (nonatomic, assign) unsigned int fbPhone_timezone;
@property (nonatomic, assign) unsigned int fbPhone_verified;

// *** Twitter ***
@property (nonatomic, strong) NSString *tw_access_token;
@property (nonatomic, strong) NSString *tw_refresh_token;
@property (nonatomic, strong) NSString *tw_id;
@property (nonatomic, strong) NSString *tw_username;

// *** Google ***
@property (nonatomic, strong) NSString *gg_access_token;
@property (nonatomic, strong) NSString *gg_refresh_token;
@property (nonatomic, strong) NSString *gg_email;
@property (nonatomic, strong) NSString *gg_id;



// *** Photo selection ***
@property (nonatomic, assign) NSString *selected_image;
@property (nonatomic, assign) unsigned int post_image_number;

// *** Media Call ***
@property (nonatomic, readwrite) BOOL hasActiveCall;
@property (nonatomic, strong) NSString *activeRoomId;
@property (nonatomic, readwrite) BOOL hasActiveInvite;
@property (nonatomic, strong) NSString *activeInviteId;
@property (nonatomic, strong) NSString *activeInviteCallType;
@property (nonatomic, strong) NSString *activeCallType;
// *** All ***
@property (nonatomic, strong) NSString *activePage;
@property (nonatomic, strong) NSString *activeSubPage;
@property (readwrite) int notificationCount;
@property (readwrite) int notificationBadgeCount;


+(UserData*)sharedData;

@end
