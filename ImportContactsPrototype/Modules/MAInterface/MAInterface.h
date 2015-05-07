//
//  MAInterface.h
//  Flickflyer
//
//  Created by Adrich on 10/19/14.
//  Copyright (c) 2014 BrewedConcepts. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LBRegisterValidationView.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface MAInterface : NSObject

#if __has_feature(objc_arc)


+ (UIImage*)convertIconFontsToImage:(NSString*)aIconFonts iconText:(const char*)aIconText TextColor:(UIColor*)textcolor iconSize:(CGSize)aSize;
+ (void)convertToIconFont:(UILabel*)aLabel iconText:(const char*)aIconText fontSize:(CGFloat)aSize;
+ (void)applyCircleWithPersentage:(int)persent imageViewObject:(UIImageView*)aImageView andTintColor:(UIColor *)color;
+(void)createRoundImageViewProfile:(UIImageView*)aImageView border:(CGFloat)aBorder;
+ (void)createRoundImageView:(UIImageView*)aImageView border:(CGFloat)aBorder;
+ (void)createBorderImageView:(UIImageView*)aImageView;

+ (void)imageViewWithPercentCellChatView:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)imageViewWithPercentCellRightChatView:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)imageViewWithPercentCell:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;
+ (void)imageViewWithPercentCellRight:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)roundImageViewWithPercent:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)roundBorderForLogo:(UIImageView*)aImageView border:(CGFloat)aBorder;

+ (UIImage *)scaleImageToSize:(CGSize)targetSize imageObject:(UIImage*)sourceImage;
+ (UIImage *)resizeImageToSize:(CGSize)targetSize imageObject:(UIImage*)sourceImage;

// *** Round image for profileCell ***
+ (void)imageViewProfileCell:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;
+ (void)imageViewProfileCellSmall:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)imageViewProfileCellLeft:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent;

+ (void)showViewControllerStoryboard:(NSString*)identifier ViewController:(UIViewController*)vController Window:(UIWindow*)aWindow storyboardWithName:(NSString*)aName animated:(BOOL)animate;

+ (void)registerErrorView:(LBRegisterValidationView*)aView messageObject:(NSArray*)mArray frameRect:(CGRect)nFrame useSingleLine:(BOOL)aLine;

+ (void)checkRuntimeOS:(NSString*)OSName CallBackOS:(void (^)(NSString *version,BOOL currentOS))checkVersionOS;
+ (CGSize)getStringSizeLabel:(UILabel*)label customWidth:(CGFloat)width customHeight:(CGFloat)height;

+ (void)getHeightLabelWithString:(UILabel*)label
                       LabelText:(NSString*)text
                        forWidth:(CGFloat)width
                        forPoint:(CGPoint)point
                   numberOfLines:(NSInteger)numLine
                    DesireHeight:(CGFloat)dHeight
                     limitHeight:(BOOL)isLimit;

+ (void)getWidthLabelWithString:(UILabel*)label LabelText:(NSString*)text forPoint:(CGPoint)point;

+ (CGSize)maxHeightForTextInRow:(NSString *)rowText width:(float)textWidth FontName:(UIFont*)font;

+ (CGRect)getTextRect:(NSString*)text Font:(UIFont*)font;

+ (NSString*)currentDateToTimeStamp;
+ (NSString*)timeStampToString:(NSString*)stringUnixDate dateFormat:(NSString*)dateFormat;
+ (NSString*)unixTimeToDateString:(NSString*)stringUnixDate dateFormat:(NSString*)dateFormat;
+ (NSString*)getDatePosted:(NSString*)aStrPostDate dateFormat:(NSString*)dateformat;
+ (void)deleteAllFilesInDirectory:(NSString*)directoryName;
+ (NSString*)generateRandomString:(int)num;


#endif

@end
