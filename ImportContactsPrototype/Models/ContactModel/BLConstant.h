//
//  BLConstant.h
//  Blumr
//
//  Created by Adrich on 12/23/14.
//  Copyright (c) 2014 Adriel. All rights reserved.
//

#ifndef Blumr_BLConstant_h
#define Blumr_BLConstant_h


#import <objc/runtime.h>
#import "FFNetworkDetect.h"
#import "LBUserData.h"
#import "UserData.h"

#if !TARGET_IPHONE_SIMULATOR

#define TARGET_BLUMR_DEVICE

#define or :
#define at ?
#define ax 1
#define ay 0
#define az id
#define _avCD ax

#ifdef _avCD
#define _avCDc AVCaptureDevice
#define _avCDi AVCaptureDeviceInput
#define _dWMt deviceWithMediaType
#define _dIWd deviceInputWithDevice
#define _cDPb AVCaptureDevicePositionBack
#define _cAddIt canAddInput
#define _addIt addInput
#define _cAddOut canAddOutput
#define _addOut addOutput
#define _cSession session
#endif

#define _camera MACameraVC
#define _a az
#define erroType &error
#define cSelf _a
#define cAWCMI _dWMt
#define cDIWD _dIWd
#define cPosC _cDPb
#define cDevcaptureInput AVCaptureDeviceInput
#define cVidDevice [_camera cAWCMI:AVMediaTypeVideo preferringPosition:cPosC]
#define cOutput [cDevcaptureInput cDIWD:videoDevice error:erroType]

#define CaptureDevice _avCDc
#define CDeviceInput _avCDi
#define cAddInput _cAddIt
#define caddInput _addIt
#define cAddOutput _cAddOut
#define addOutput _addOut
#define cCsession _cSession
#define cInitVideo initVideo
#define cstartQueueAndObserver startQueueAndObserver
#define cstopQueueAndObserver stopQueueAndObserver

#endif

#define FFCheckObject(objcf)   assert(objcf!=nil)
#if __has_feature(objc_arc)
#define LBLog(objcf,...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:objcf,## __VA_ARGS__])
#define FFMarkMethodAndClass(objClass) LBLog(@"LINE: %i : %s : (%s)",__LINE__,__FUNCTION__,class_getName([objClass class]))
#else
#define LBLog(objcf, ...) CFShow([NSString stringWithFormat:objcf,## __VA_ARGS__])
#define FFMarkMethodAndClass(objClass) LBLog(@"LINE: %i : %s : (%s)",__LINE__,__FUNCTION__,class_getName([objClass class]))
#endif

#define FFLog(formatString, ...) LBLog((@"%s " formatString),__PRETTY_FUNCTION__, ##__VA_ARGS__);

// Enable Log
// Note: Run clean after disable this log
#define LB_ENABLE_LOG                       1
#define LB_DISABLE_LOG_DEFAULT              1


#define onWebSocket                         1

#define URLSocket_DEVELOPMENT               @"wss://betablumr.com/ws/websocket"
#define URLSocket_ADHOC                     @"wss://beta.blumr.com/ws/websocket"

#ifdef __LP64__
#define lb_hash_value(objc_value)           [NSString stringWithFormat:@"%lu",objc_value]
#else
#define lb_hash_value(objc_value)           [NSString stringWithFormat:@"%d",objc_value]
#endif

#pragma mark-
#pragma mark< == NETWORK TYPE (ENUM) == >
#pragma mark-

#ifndef kLBCheckNetwork
#define kLBCheckNetwork                     [FFNetworkDetect ffnetworkConnectionType]
#define kLBIpAddress                        [FFNetworkDetect myIPAddress]
#endif

#pragma mark-
#pragma mark < === USERDATA === >

#define UserData                            [UserData sharedData]

#pragma mark-
#pragma mark < === BLOCKS SOCKET === >

#define lb_print_CGRect(rect)               NSStringFromCGRect(rect)


typedef void (^SocketMsg)(id socketmsg);
typedef void (^SocketConnect)(BOOL connected);


typedef enum _CurrentDevice{
    BL_DEVICE_iPhone4,
    BL_DEVICE_iPhone5,
    BL_DEVICE_iPhone6,
    BL_DEVICE_iPhone6Plus
}CurrentDevice;

typedef void (^BLCurrentDevice)(CurrentDevice device);

typedef enum _signUpUsing
{
    REG_DEFAULT,
    REG_MOBILE,
    REG_FACEBOOK,
    REG_GOOGLE,
    REG_TWITTER
}SignUpUsing;

typedef enum _lbcurrentview
{
    LB_SIGN_UP,
    LB_SIGN_IN,
    LB_EASY_SIGN_UP,
    LB_FORGOT_PASSWORD,
    LB_NULL
}LBCurrentView;

typedef enum _lbtoggleview{
    LB_INVALID_VIEW,
    LB_PROFILE,
    LB_LOGIN,
    LB_TAG
}LBToggleView;

typedef enum _lbSignUpWarning{
    LB_SU_OK,
    LB_SU_EMPTY,
    LB_SU_INVALID_CHARACTER,
    LB_SU_EMAIL,
    LB_SU_USERNAME,
    LB_SU_PASSWORD
}LBSignUpWarning;

typedef enum _lbEasyRegister{
    LB_ES_OK,
    LB_ES_EMPTY,
    LB_ES_EMAIL,
    LB_ES_MOBILE
}LBEasyRegister;


typedef enum _lbSignInWarning{
    LB_SI_OK,
    LB_SI_EMPTY,
    LB_SI_EMAIL_USERNAME,
    LB_SI_PASSWORD
}LBSignInWarning;

typedef enum _lbForgotPasswordWarning{
    LB_FP_OK,
    LB_FP_EMAIL,
    LB_FP_EMAIL_NOT_REGISTER
}LBForgotPasswordWarning;


typedef enum _LBViewPosition{
    LBViewToBottom  = (1 << 0),
    LBViewToTop     = (1 << 1),
    LBViewToRight   = (1 << 2),
    LBViewToLeft    = (1 << 3)
}LBViewPosition;


#pragma mark-
#pragma mark < === CONSTANT DEFINE === >

#define blumr_font_light                            @"Roboto-Light"
#define blumr_font_regular                          @"Roboto-Regular"

#pragma mark-
#pragma mark < === BLUMR COLOR === >

#define blumr_color_white                           [UIColor colorWithRed:1 green:1 blue:1 alpha:0.60]
#define blumr_color_white_solid                     [UIColor colorWithRed:1 green:1 blue:1 alpha:1]

#define blumr_color_gray_logo_font                  [UIColor colorWithRed:0.43 green:0.44 blue:0.44 alpha:1.00]
#define blumr_color_gray_textinput_default_icon     [UIColor colorWithRed:0.59 green:0.59 blue:0.60 alpha:1.00]
#define blumr_color_gray_icon_lines_offline         [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00]
#define blumr_color_gray_bg                         [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.00]

#define blumr_color_blue_dark                       [UIColor colorWithRed:0.06 green:0.46 blue:0.74 alpha:1.00]
#define blumr_color_blue                            [UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.00]
#define blumr_color_blue_light                      [UIColor colorWithRed:0.80 green:0.93 blue:1.00 alpha:1.00]
#define blumr_color_blue_hover                      [UIColor colorWithRed:0.47 green:0.83 blue:1.00 alpha:1.00]

#define blumr_color_green_trends                    [UIColor colorWithRed:0.33 green:0.73 blue:0.00 alpha:1.00]
#define blumr_color_green_availability              [UIColor colorWithRed:0.47 green:0.80 blue:0.00 alpha:1.00]

#define blumr_color_red_trends_icon                 [UIColor colorWithRed:0.93 green:0.40 blue:0.40 alpha:1.00]
#define blumr_color_red_availability                [UIColor colorWithRed:1.00 green:0.47 blue:0.47 alpha:1.00]

#define blumr_color_orange_trends                   [UIColor colorWithRed:1.00 green:0.71 blue:0.00 alpha:1.00]
#define blumr_color_orange_availability             [UIColor colorWithRed:1.00 green:0.80 blue:0.47 alpha:1.00]

#define blumr_color_media_menu_bg                   UIColorFromRGB(0xf7f7f7)


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define statusBarHeight                             26.0f
#define navigationBarHeight                         44.0f

#pragma mark Sign IN/UP (FRESH INSTALL)

// *** Flag Edit update Profile ***
//#define bl_setNeedToUpdateProfile(objcValue)     [LBUserData setAppString:objcValue forKey:@"updateProfile"];
//#define bl_NeedToUpdateProfile                   ([[LBUserData getAppString:@"updateProfile"] isEqualToString:@"YES"]\
//                                                 && [LBUserData getAppString:@"updateProfile"] != nil) ? 1 : 0


#define bl_setIsUserLogin(objcValue)        [LBUserData setAppString:objcValue forKey:@"isLogin"];
#define bl_getIsUserLogin                            ([[LBUserData getAppString:@"isLogin"] isEqualToString:@"YES"]\
    && [LBUserData getAppString:@"isLogin"] != nil) ? 1 : 0

#pragma mark WELCOME PAGE (TOGGLE SIGN-IN,SIGN-UP and EASYSIGN-UP)

// *** Easy SignUpView ***
#define bl_setNeedToRegister(objcValue)     [LBUserData setAppString:objcValue forKey:@"toRegister"];
#define bl_NeedToRegister                   ([[LBUserData getAppString:@"toRegister"] isEqualToString:@"YES"]\
    && [LBUserData getAppString:@"toRegister"] != nil) ? 1 : 0

// *** SignInVC ***
#define bl_setNeedToSignIn(objcValue)       [LBUserData setAppString:objcValue forKey:@"toSignIn"];
#define bl_NeedToSignIn                     ([[LBUserData getAppString:@"toSignIn"] isEqualToString:@"YES"]\
    && [LBUserData getAppString:@"toSignIn"] != nil) ? 1 : 0
// *** SignUpVC ***
#define bl_setNeedToSignUp(objcValue)       [LBUserData setAppString:objcValue forKey:@"toSignUp"];
#define bl_NeedToSignUp                     ([[LBUserData getAppString:@"toSignUp"] isEqualToString:@"YES"]\
    && [LBUserData getAppString:@"toSignUp"] != nil) ? 1 : 0

// *** WelcomePage ***
#define bl_setShowFreshInstall(objcValue)   [LBUserData setAppString:objcValue forKey:@"freshInstall"];
#define bl_showFreshInstall                 ([[LBUserData getAppString:@"freshInstall"] isEqualToString:@"YES"]\
    && [LBUserData getAppString:@"freshInstall"] != nil) ? 1 : 0


#pragma mark Country Selected

#define bl_setCountryName(objcValue)        [LBUserData setAppString:objcValue forKey:@"countryName"];
#define bl_getCountryNameSelected           ([LBUserData getAppString:@"countryName"] != nil) ? [LBUserData\
    getAppString:@"countryName"] : @""

#define bl_setCountryCode(objcValue)        [LBUserData setAppString:objcValue forKey:@"countryCode"];
#define bl_getCountryCodeSelected           ([LBUserData getAppString:@"countryCode"] != nil) ? [NSString\
    stringWithFormat:@"+%@",[LBUserData getAppString:@"countryCode"]] : @""

#define bl_setCountryFlag(objcValue)        [LBUserData setAppString:objcValue forKey:@"countryFlag"];
#define bl_getCountryFlagSelected           ([LBUserData getAppString:@"countryFlag"] != nil) ? [NSString\
    stringWithFormat:@"%@.png",[LBUserData getAppString:@"countryName"]] : @""

#define bl_setSelectedSignUp(objcValue)     [LBUserData setAppString:objcValue forKey:@"selectedSignUp"];
#define bl_getSelectedSignUp                ([LBUserData getAppString:@"selectedSignUp"] != nil) ? [LBUserData\
    getAppString:@"selectedSignUp"] : @""


#define LBProfileImage                      @"profileImage.png"
#define LBPostImage(objName)                [NSString stringWithFormat:@"%@.png",objName]


#define FFCONTENT_TYPE                      @"Content-Type"
#define FFCONTENT_TYPE_IMAGE_JPG            @"Content-Type: image/jpeg\r\n\r\n"
#define FFCONTENT_TYPE_IMAGE_PNG            @"Content-Type: image/png\r\n\r\n"
#define FFCONTENT_TYPE_IMAGE_GIF            @"Content-Type: image/gif\r\n\r\n"

#define FFMIME_TYPE_UNDEFINE                @""
#define FFMIME_TYPE_OCTET_STREAM            @"Content-Type: application/octet-stream\r\n\r\n"
#define FFMIME_TYPE_VIDEO_MOV               @"Content-Type: video/quicktime\r\n\r\n"
#define FFMIME_TYPE_VIDEO_3GP               @"Content-Type: video/3gp\r\n\r\n"
#define FFMIME_TYPE_VIDEO_MP4               @"Content-Type: video/mp4\r\n\r\n"




#pragma mark-
#pragma mark ERROR MESSAGE


#define kRegCharacterMIN                    (6)

#define ACCEPTABLE_CHARACTERS               @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_."

// EASY SIGN UP
#define SU_Email_already_registered         @"Aww. Looks like that email’s already registered with us."
#define SU_Email_already_registered_hint    @"Try a social network for signing up or use mobile instead."

#define SU_Email_invalid_format             @"Looks like an invalid email address if ya ask me. ;-)"
#define SU_Email_invalid_format_hint        @"The email must be at least 6 characters long and must contain a valid domain and name."

#define SU_Email_empty                      @"Forgot to enter your email?"
#define SU_Email_empty_hint                 @"Please enter your email."

#define SU_Mobile_empty                     @"Forgot to enter your mobile?"
#define SU_Mobile_empty_hint                @"Please enter your mobile."

#define SU_Mobile_already_registered        @"Looks like your mobile has already been registered."
#define SU_Mobile_already_registered_hint   @"Try a social network for signing up or use email instead."






// Sign In
#define signInWarningEmailUsername          @"The username or email must be at least 6 characters long."
#define signInWarningEmpty                  @"Please enter your username and password."
#define signInWarningPassword               @"Password must be at least 6 characters long."
#define signInWarningInvalidUserAndPswd     @"Your username and/or password was invalid."
#define signInWarningUsernameOrEmailAndPswd @"Please enter your username or email and password."
#define signInWarningWrngUsernameAndPswd    @"Either wrong username or password or both! :-P"

// Sign Up
#define signUpWarningEmpty                  @"Please provide an email, a username and a password."
#define signUpWarningPassword               @"The password must be at least 6 characters long."
#define signUpWarningValidEmail             @"The email must be at least 6 characters long and must contain a valid domain and name."
#define signUpWarningUsername               @"The username must be at least 6 characters long."
// [SR]
#define signUpWarningEmailTaken             @"The email has already been registered."
#define signUpWarningUserNameTaken          @"The username has already been taken."

// Forgot Password
#define FPWarningEmailNotBeenRegistered     @"The email has not been registered yet."
#define FPWarninginValidEmail               @"The email must be at least 6 characters long and must contain a valid domain and name."
// Message to user
#define FPMessageToUserP1                   @"We've sent an email to"
#define FPMessageToUserP2                   @"Click the link in your email to reset your Blumr password."
#define FPMessageToUserP3                   @"If you don't see the email, check your social, spam or other folders."


#define SU_Email_email_invalid              @"There’s something wrong with your email, friend. :-)"
#define SU_Empty_fields                     @"Forgot to enter your email, username and password? :-)"
#define SU_Username_taken                   @"Someone beat you to that username! Try a different one!"
#define SU_empty_field(str)                 [NSString stringWithFormat:@"Please enter your %@",str]
#define SU_Username_char_invalid(c)         [NSString stringWithFormat:@"“%@” not allowed. Letters, numbers & underscore only.",c]

#define SU_Password_character(character)    [NSString stringWithFormat:@"Almost there! %d more characters and we’re good!",character]
#define SU_Username_character(character)    [NSString stringWithFormat:@"Almost there! Your username needs only %d more character",character]

// FORGOT PASSWORD
#define FP_empty                            @"Forgot to enter your email or mobile?"
#define FP_empty_hint                       @"Please enter your email or mobile."
#define FP_emailMobile_character(character) [NSString stringWithFormat:@"Almost there! %d more characters and we’re good!",character]
#define FP_emailMobile_character_hint       @"The email or mobile must be at least 6 characters long."
#define FP_emailNotExist                    @"Seems like the email or mobile doesn't exist."
#define FP_notFound                         @"Account not found."

// SIGN IN

#define SI_Username_character               @"Username or email must be at least 6 characters long."
#define SI_Username_empty                   @"Looks like you forgot to input anything. :-p"
#define SI_Password_character               @"Looks like your password is too short for comfort. :-)"
#define SI_Pswd_username_invalid            @"Tricky password? Enable Show Password (eye icon)"

// Hint
#define hintUserNameSignIN                  @"The username must be atleast 6 characters long. Allowed characters are alphanumeric and underscore."
#define hintWrongUsernameOrPwsdSignIN       @"Your username and/or password was invalid."

// VERIFICATION

#define VC_empty_character                  @"Looks like you forgot to enter the 6-character code. :-p"
#define VC_empty_character_hint             @"Check your other folders, like your junk, spam or social."

#define VC_invalid_code                     @"Oooh, looks like your code is somehow invalid, friend. :-)"
#define VC_invalid_code_hint                @"Double check your 6-character code. Remember, they're case sensitive."

// MEDIA CALL

#define RTC_OFFER_CONSTRAINTS @"offerConstraints"
#define RTC_ICE_CONSTRAINTS @"iceConstraints"
#define RTC_VIDEO_CONSTRAINTS @"iceConstraints"
#define RTC_FACTORY @"peerConnectionFactory"

#define RTC_SENDONLY @"sendonly"
#define RTC_RECVONLY @"recvonly"
#define RTC_SENDRECV @"sendrecv"

#define RTC_ACTION @"action_state"

#define MAIN @"mainController"
#define USERKEYID @"userKeyId"

#define LOCAL_SDP @"localDescription"
#define REMOTE_SDP @"remoteDescription"

#define SDP_ANSWER @"answer"
#define SDP_OFFER @"offer"

// video constraints
#define VWIDTH @"100" // 100
#define VHEIGHT @"75" // 75
#define VFPS @"10"

#define MAX_WIDTH @"maxWidth"
#define MIN_WIDTH @"minWidth"
#define MAX_HEIGHT @"maxHeight"
#define MIN_HEIGHT @"minHeight"
#define MIN_FPS @"maxFrameRate"
#define MAX_FPS @"minFrameRate"

#define KEY_FALSE @"false"
#define KEY_TRUE @"true"

#define RTC_OFFER_AUDIO @"OfferToReceiveAudio"
#define RTC_OFFER_VIDEO @"OfferToReceiveVideo"
#define RTC_SCTP_DATACHANNELS @"internalSctpDataChannels"
#define RTC_DTLS_SRTP @"DtlsSrtpKeyAgreement"
#define RTC_G_LEAKYBUCKET @"googLeakyBucket"
#define RTC_G_NOISEREDUCTION @"googNoiseReduction"
#define RTC_G_WIFIBWE @"googImproveWifiBwe"
#define RTC_G_CPU_OVERDETECT @"googCpuOveruseDetection"
#define RTC_G_CPU_OVERENCODE @"googCpuOveruseEncodeUsage"
#define RTC_G_CPU_UNDERTHRESHOLD @"googCpuUnderuseThreshold"
#define RTC_G_CPU_OVERTHRESHOLD @"googCpuOveruseThreshold"
#define RTC_G_CPU_SKIP_ENCODE_STREAMS @"googSkipEncodingUnusedStreams"
#define RTC_G_SCREENCAST_MIN_BITRATE @"googScreencastMinBitrate"
#define RTC_G_HIGH_BITRATE @"googHighBitrate"
#define RTC_G_VERY_HIGH_BITRATE @"googVeryHighBitrate"
#define RTC_G_PLAYLOAD_PADDING @"googPlayloadPadding"
#define RTC_G_ECHO_CANCEL @"googEchoCancellation"
#define RTC_G_AUTO_GAIN @"googAutoGainControl"
#define RTC_G_NOISE_SUPPRESSION @"googNoiseSuppression"
#define RTC_G_HIGH_FILTER @"googHighpassFilter"
#define RTC_G_AUDIO_MIRROR @"googAudioMirroring"
#define RTC_G_NOISE_SUPPRESION2 @"googNoiseSuppression2"
#define RTC_G_ECHO_CANCEL2 @"googEchoCancellation2"
#define RTC_G_AUTO_GAIN2 @"googAutoGainControl2"
#define RTC_G_DUCKING @"googDucking"
#define RTC_G_ASSOC_SINK @"chromeRenderToAssociatedSink"


// Action>Convey
#define ACTION_GET_ROOM @"get_room"
#define ACTION_LIST_PARTICIPANT @"list_participant"
#define ACTION_LIST_PARTICIPANTS @"list_participants"
#define ACTION_ACTIVE_PARTICIPANT @"active_participant"

#define ACTION_LIVE_MESSAGE @"live_message"
#define ACTION_SEND_MESSAGE @"send_message"
#define ACTION_LIST_MESSAGES @"list_messages"

#define ACTION_MY_ROOMS @"my_rooms"
#define ACTION_MY_CALL @"my_call"
#define ACTION_CHANGE_TYPE @"change_type"
#define ACTION_START_CALL @"start_call"
#define ACTION_STOP_CALL @"stop_call"

// Action>Friends
#define ACTION_LIST_FRIENDS @"list_friends"
#define ACTION_LIST_INVITES @"list_invites"
#define ACTION_SYNC_CONTACTS @"sync_contacts"
#define ACTION_LIST_SOCIAL_FRIENDS @"list_social_friends"
#define ACTION_INVITE_SOCIAL_FRIENDS @"invite_social_friends"
#define ACTION_ACCEPT_INVITE @"accept_invite"
#define ACTION_SEND_INVITE @"send_invite"
#define ACTION_IGNORE_INVITE @"ignore_invite"
#define ACTION_CANCEL_INVITE @"cancel_invite"
#define ACTION_REMOVE_FRIEND @"remove_friend"

// Action>User
#define ACTION_CHECK_AVAILABILITY @"check_availability"
#define ACTION_FORGOT_PASSWORD @"forgot_password"
#define ACTION_VIEW_PROFILE @"view_profile"
#define ACTION_EDIT_AVAILABILITY @"edit_availability"
#define ACTION_EDIT_PASSWORD @"edit_password"
#define ACTION_EDIT_STATUSMSG @"edit_status_message"
#define ACTION_EDIT_GENDER @"edit_gender"
#define ACTION_EDIT_AVATAR @"edit_avatar"
#define ACTION_EDIT_FULL_NAME @"edit_full_name"
#define ACTION_EDIT_LOCATION @"edit_location"
#define ACTION_EDIT_BIRTHDAY @"edit_birthdate"

// Action>Auth
#define ACTION_LOGOUT @"logout"

#define MODULE_CONVEY @"convey"
#define MODULE_FRIEND @"friend"
#define MODULE_USER @"user"
#define MODULE_TREND @"trend"
#define MODULE_AUTH @"auth"
#define MODULE_ALL @"all"

#define KEY_MODULE @"module"
#define KEY_MOBILE @"mobile"
#define KEY_ACTION @"action"
#define KEY_ADDRESS @"address"
#define KEY_ROUTE @"route"
#define KEY_PAYLOAD @"payload"
#define KEY_BROADCAST @"broadcast"
#define KEY_RESPONSE @"response"
#define KEY_CODE @"code"
#define KEY_EMAIL @"email"
#define KEY_OFFERS @"offers"
#define KEY_OLD_PASSWORD @"old_password"
#define KEY_NEW_PASSWORD @"new_password"
#define KEY_CALL_LIST @"callers"
#define KEY_CALL_TYPE @"call_type"
#define KEY_IDENTITY @"identity"
#define KEY_AUDIO @"audio"
#define KEY_VIDEO @"video"
#define KEY_VALUE @"value"
#define KEY_IDENTITY @"identity"
#define KEY_INVITER @"inviter"
#define KEY_INVITEE @"invitee"
#define KEY_CALL_EVENT @"call_event"
#define KEY_TIMESTAMP @"timestamp"
#define KEY_LAST_ACTIVE @"last_active"
#define KEY_USERNAME @"username"
#define KEY_ROOMID @"room_id"
#define KEY_FRIENDS @"friends"
#define KEY_PARTICIPANTS @"participants"
#define KEY_GROUPNAME @"group_name"
#define KEY_GENDER @"gender"
#define KEY_AVAILABILITY @"availability"
#define KEY_AVATAR @"avatar"
#define KEY_EXPERIENCE @"experience"
#define KEY_LEVEL @"level"
#define KEY_PERCENT @"percent"
#define KEY_FULLNAME @"full_name"
#define KEY_FIRSTNAME @"first_name"
#define KEY_MIDDLENAME @"middle_name"
#define KEY_LASTNAME @"last_name"
#define KEY_TYPE @"type"
#define KEY_IDENTITIES @"identities"
#define KEY_MSG @"message"
#define KEY_MSG_ID @"message_id"
#define KEY_STICKER @"sticker"
#define KEY_STATUS @"status"
#define KEY_BLUMRSINCE @"blumr_since"
#define KEY_STATUS_MSG @"status_message"
#define KEY_OFFSET @"offset"
#define KEY_LIMIT @"limit"
#define KEY_CALLERS @"callers"
#define KEY_ROOMS @"rooms"
#define KEY_ISCALLER @"is_caller"
#define KEY_ISACTIVE @"is_active"
#define KEY_LAST_TYPE @"last_type"
#define KEY_LAST_MESSAGE @"last_message"


#define EVENT_FROM_FRIENDSPROFILE_CALL @"event.from.friends.profile"

#define CALL_IGNORE @"ignore"
#define CALL_DECLINE @"decline"
#define CALL_TRANSFER @"transfer"
#define CALL_END @"end"

#define CALL_INVITE @"invite_call"
#define CALL_JOIN @"join_call"
#define CALL_SWITCH @"switch_call"

#define CODE_INAUTHENTIC @"inauthentic"
#define CODE_ASTRAY @"astray"
#define CODE_ERROR @"error"
#define CODE_SUCCESS @"success"
#define CODE_INVALID @"invalid"
#define CODE_CONFLICT @"conflict"
#define CODE_INCOMPLETE @"incomplete"
#define CODE_RESTRICTED @"restricted"
#define CODE_UNAUTHORIZED @"unthorized"
#define CODE_NONEXISTENT @"nonexistent"

#define CODE_IGNORE @"ignore"
#define CODE_DECLINE @"decline"
#define CODE_END @"end"

#define TEMP_ROOMID @"amazon"
#define DOMAIN_MEDIA_TEST @"ws://54.169.61.111:8585/media/ws/websocket/"

#define BLANK @""

#define NOTIF_BROADCAST_CALL @"convey_broadcast"

#define PAGE_CONTACTS @"contacts"
#define PAGE_TRENDS @"trends"
#define PAGE_WELCOME @"welcome"

#define SUBP_CONTACT_LIST @"contact.infolist"
#define SUBP_CONTACT_MESSAGE @"contact.message.group"
#define SUBP_CONTACT_MESSAGE_LIST @"contact.message.list"
#define SUBP_CONTACT_CONVERSATION_LIST @"contact.conversation.list"
#define SUBP_CONTACT_HISTORY @"contact.message.history"
#define SUBP_CONTACT_NOTIFICATION @"contact.notification"
#define SUBP_CONTACT_INVITE @"contact.send.invite"
#define SUBP_BACKGROUND @"background"

#define SUBP_MSG_BOX @"message.conversation.box"
#define SUBP_MSG_ADD_PARTICIPANT @"message.conversation.add.participant"
#define SUBP_MSG_ADD_PARTICIPANT_LIST @"message.conversation.add.participant.list"

#define SUBP_NOTIF_CALL @"notif.call"

#define NOTIFICATION_BROADCAST_SENTMSG @"notification.sent.message"
#define NOTIFICATION_BROADCAST_EDITAVAILABILITY @"notification.edit.availability"
#define NOTIFICATION_BROADCAST_SENDINVITE @"notification.send.invite"
#define NOTIFICATION_BROADCAST_LOGOUT @"notification.logout"
#define NOTIFICATION_EDIT_AVAILIBITY @"notification.local.edit.availability"
#define NOTIFICATION_CONTACTS_RESETPAGE @"notification.resetContacts"
#define NOTIFICATION_SHOW_FORGOTPASSWORDVIEW @"showForgotPasswordView"

#define AVAILABILITY_ONLINE @"online"
#define AVAILABILITY_IDLE @"idle"
#define AVAILABILITY_OFFLINE @"offline"
#define AVAILABILITY_BUSY @"busy"

#define MSG_STATUS_UNREAD @"unread"
#define MSG_STATUS_READ @"read"
#define MSG_STATUS_SENT @"sent"

#define NETSTAT_NO_NETWORK @"network.no.network"
#define NETSTAT_RECONNECTING @"network.reconnecting"
#define NETSTAT_CONNECTED @"network.connected"

#define NETSTAT_NO_NETWORK_MSG1 @"This action requires internet connectivity."
#define NETSTAT_NO_NETWORK_MSG2 @"Please wait for the app to re-establish"
#define NETSTAT_NO_NETWORK_MSG3 @"your connection."

#define NETSTAT_RECONNECTING_MSG1 @"Connecting"
#define NETSTAT_RECONNECTING_MSG2 @""

#define NETSTAT_CONNECTED_MSG1 @"Connected"
#define NETSTAT_CONNECTED_MSG2 @""

#define NETSTAT_TAG 100
#define NETSTAT_CONNECTING_TAG 101

#define UPDATE_SENDINVITES @"update.send.invites"
#define UPDATE_FRIENDSLIST @"update.friendslist"

#define UPDATE_SENDINVITES @"update.send.invites"
#define UPDATE_FRIENDSLIST @"update.friendslist"


#endif