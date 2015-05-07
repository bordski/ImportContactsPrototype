//
//  MAInterface.m
//  Flickflyer
//
//  Created by Adrich on 10/19/14.
//  Copyright (c) 2014 BrewedConcepts. All rights reserved.
//

#import "MAInterface.h"
#include <sys/time.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "BLConstant.h"



static inline double radians (double degrees) { return degrees * M_PI / 180; }

@implementation MAInterface


#if __has_feature(objc_arc)

+(UIImage*)convertIconFontsToImage:(NSString*)aIconFonts iconText:(const char*)aIconText TextColor:(UIColor*)textcolor iconSize:(CGSize)aSize
{
    UIGraphicsBeginImageContext(aSize);
    
    UILabel *iconFonts = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, aSize.width, aSize.height)];
    
    [iconFonts setFont:[UIFont fontWithName:aIconFonts size:aSize.height]];
    [iconFonts setText:[NSString stringWithUTF8String:aIconText]];
    [iconFonts setTextColor:textcolor];
    
    // Make the CALayer to draw in our "canvas".
    [[iconFonts layer] renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Set this method to use in tabBarItem
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    
    iconFonts = nil;
    // Return the image.
    return image;
}

+(void)convertToIconFont:(UILabel*)aLabel iconText:(const char*)aIconText fontSize:(CGFloat)aSize
{
    [aLabel setFont:[UIFont fontWithName:@"blumrcons" size:aSize]];
    [aLabel setText:[NSString stringWithUTF8String:aIconText]];
}

+(void)roundBorderForLogo:(UIImageView*)aImageView border:(CGFloat)aBorder
{
    if (aImageView != nil)
    {
        aImageView.clipsToBounds = YES;
        [aImageView.layer setBorderWidth:aBorder];
        [aImageView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        
        CGFloat width = aImageView.bounds.size.width;
        [aImageView.layer setCornerRadius:width/2];
    }
}

+(void)createRoundImageViewProfile:(UIImageView*)aImageView border:(CGFloat)aBorder
{
    if (aImageView != nil)
    {
        aImageView.clipsToBounds = YES;
        [aImageView.layer setBorderWidth:aBorder];
        [aImageView.layer setBorderColor:[blumr_color_blue CGColor]];
        
        /*[p]
         [aImageView.layer setShadowRadius:3.0];
         [aImageView.layer setShadowOpacity:0.5];
         [aImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
         [aImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
         */
        
        CGFloat width = aImageView.bounds.size.width;
        [aImageView.layer setCornerRadius:width/2];
    }
    
}

+(void)createRoundImageView:(UIImageView*)aImageView border:(CGFloat)aBorder
{
    if (aImageView != nil)
    {
        aImageView.clipsToBounds = YES;
        [aImageView.layer setBorderWidth:aBorder];
        [aImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
        
        /*[p]
         [aImageView.layer setShadowRadius:3.0];
         [aImageView.layer setShadowOpacity:0.5];
         [aImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
         [aImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
         */
        
        CGFloat width = aImageView.bounds.size.width;
        [aImageView.layer setCornerRadius:width/2];
    }
    
}

+(void)roundImageViewWithPercent:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(6, 7, 85, 80);
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 7,
                                   aImageViewB.frame.origin.y + 4,
                                   aImageViewB.frame.size.width - 14,
                                   aImageViewB.frame.size.height - 8);
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.00]];
    }
    
}


+(void)imageViewWithPercentCellChatView:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(1, 3, 60, 55);
    
    
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 20,
                                   aImageViewB.frame.origin.y + 11,
                                   aImageViewB.frame.size.width - 10,
                                   aImageViewB.frame.size.height - 5);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}

+(void)imageViewWithPercentCellRightChatView:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(320 - 65, 9, 61, 56);//75, 67
    
    
    aImageViewA.frame = CGRectMake(320 - 58,
                                   aImageViewB.frame.origin.y + 3.5,
                                   aImageViewB.frame.size.width - 14,
                                   aImageViewB.frame.size.height - 8);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}

// *** LEFT IMAGE POSITION ***
+(void)imageViewWithPercentCell:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(0, 0, 75, 70);
    
    
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 20,
                                   aImageViewB.frame.origin.y + 13,
                                   aImageViewB.frame.size.width - 10,
                                   aImageViewB.frame.size.height - 5);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}


// RIGHT IMAGE POSITION
+(void)imageViewWithPercentCellRight:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(320 - 82, 9, 72, 64);//75, 67
    
    
    aImageViewA.frame = CGRectMake(320 - 75,
                                   aImageViewB.frame.origin.y + 2,
                                   aImageViewB.frame.size.width - 14,
                                   aImageViewB.frame.size.height - 4);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}


+(void)imageViewProfileCell:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(0, 0, 75, 70);
    
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 20,
                                   aImageViewB.frame.origin.y + 16,
                                   aImageViewB.frame.size.width - 10,
                                   aImageViewB.frame.size.height - 5);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}

+ (void)imageViewProfileCellSmall:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent {
    
    aImageViewB.frame = CGRectMake(0, 0, 48, 48);
    
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 20,
                                   aImageViewB.frame.origin.y + 10,
                                   aImageViewB.frame.size.width - 10,
                                   aImageViewB.frame.size.height - 10);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:2.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
    
}


+(void)imageViewProfileCellLeft:(UIImageView*)aImageViewA precentImageView:(UIImageView*)aImageViewB Percent:(int)percent
{
    aImageViewB.frame = CGRectMake(10, 10, 75, 70);
    
    aImageViewA.frame = CGRectMake(aImageViewB.frame.origin.x + 5,
                                   aImageViewB.frame.origin.y + 2,
                                   aImageViewB.frame.size.width - 10,
                                   aImageViewB.frame.size.height - 5);
    
    
    if (aImageViewA != nil)
    {
        [MAInterface createRoundImageView:aImageViewA border:3.0f];
    }
    
    if (aImageViewB != nil)
    {
        [MAInterface applyCircleWithPersentage:percent imageViewObject:aImageViewB andTintColor:[UIColor colorWithRed:0.00 green:0.68 blue:0.94 alpha:1.0f]];
    }
    
}


+(void)createBorderImageView:(UIImageView*)aImageView
{
    [aImageView.layer setBorderWidth:4.0f];
    [aImageView.layer setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [aImageView.layer setShadowRadius:3.0];
    [aImageView.layer setShadowOpacity:0.5];
    [aImageView.layer setShadowOffset:CGSizeMake(1.0, 0.0)];
    [aImageView.layer setShadowColor:[[UIColor blackColor] CGColor]];
}


+(void)applyCircleWithPersentage:(int)persent imageViewObject:(UIImageView*)aImageView andTintColor:(UIColor *)color
{
    
    // begins image context with the size of the imageView and the scale of the actual device (retina, non retina)
    UIGraphicsBeginImageContextWithOptions(aImageView.frame.size, NO, [[UIScreen mainScreen] scale]);
    // creates a graphics context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // sets the distance of the circle to the cell frame in pixels
    CGFloat arcPadding = 5.5;
    // creates the radius of the circle
    CGFloat arcRadius = (aImageView.frame.size.width / 2) - arcPadding;
    // sets the center of the circle
    CGPoint arcCenter = CGPointMake(aImageView.frame.size.width / 2, aImageView.frame.size.height / 2);
    
    // the first cicle is always displayed 100% and gets overdrawn by the second circle with the real percentage!
    // sets the degree for the first circle
    CGFloat startAngle = radians(0);
    CGFloat endAngle = radians(360);
    
    // creates the path of the first circle in counter clockwise (the last value is "0")
    CGContextAddArc(context, arcCenter.x, arcCenter.y, arcRadius, startAngle, endAngle, 0);
    // sets the linewidth of the first circle
    CGContextSetLineWidth(context, 4.0f);
    
    // gets the RGBA-values of the color
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    // sets the RGB-values and lowers the Alpha-value to make the first circle lighter
    [[UIColor colorWithRed:red green:green blue:blue alpha:0.1f] setStroke];
    // draws the first circle
    CGContextStrokePath(context);
    
    // Same here for the second circle!
    // we use the 270° to start at the top to draw the circle
    startAngle = radians(270);
    // sets the persentage value in degrees
    endAngle = radians(270 - (360 * persent) / 100);
    
    // adds the circle path in clockwise direction (the last value is "1")
    CGContextAddArc(context, arcCenter.x, arcCenter.y, arcRadius, startAngle, endAngle, 1);
    // sets the linewidth for the second circle
    CGContextSetLineWidth(context, 4.0f);
    // sets the full color for the second circle
    [color setStroke];
    // draws the second one
    CGContextStrokePath(context);
    
    
    // creates the image
    UIImage *retImage = UIGraphicsGetImageFromCurrentImageContext();
    // ends the graphics context
    UIGraphicsEndImageContext();
    // sets the image for the imageView
    [aImageView setImage:retImage];
    
    
}


+ (UIImage *)scaleImageToSize:(CGSize)targetSize imageObject:(UIImage*)sourceImage
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    
    if(CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // make image center aligned
        if (widthFactor < heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor > heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    [sourceImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    return newImage ;
}

// Resize image for gallery in details, postAdPreview and postAdViewController
+ (UIImage *)resizeImageToSize:(CGSize)targetSize imageObject:(UIImage*)sourceImage
{
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    UIGraphicsBeginImageContext(targetSize);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    
    [sourceImage drawInRect:thumbnailRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    return newImage ;
}


+(void)showViewControllerStoryboard:(NSString*)identifier ViewController:(UIViewController*)vController Window:(UIWindow*)aWindow storyboardWithName:(NSString*)aName animated:(BOOL)animate
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:aName bundle:nil];
    
    vController = [storyboard instantiateViewControllerWithIdentifier:identifier];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vController];
    
    [aWindow makeKeyAndVisible];
    [aWindow.rootViewController presentViewController:nav
                                             animated:animate
                                           completion:nil];
}

+(void)registerErrorView:(LBRegisterValidationView*)aView messageObject:(NSArray*)mArray frameRect:(CGRect)nFrame useSingleLine:(BOOL)aLine
{
    aView.hidden = NO;
    aView.frame = nFrame;
    [aView titleError:[mArray objectAtIndex:0] hintText:[mArray objectAtIndex:1] useSingleLine:aLine];
}

+ (void)checkRuntimeOS:(NSString*)OSName CallBackOS:(void (^)(NSString *version,BOOL currentOS))checkVersionOS
{
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(OSName))
    {
        checkVersionOS(OSName,YES);
    }
}

+ (CGSize)getStringSizeLabel:(UILabel*)label customWidth:(CGFloat)width customHeight:(CGFloat)height
{
    //2000.0
    CGSize constraint = CGSizeMake(width, height);
    CGSize size;
    
    __block BOOL latestOS = NO;
    
    [MAInterface checkRuntimeOS:@"7.0" CallBackOS:^(NSString *version, BOOL currentOS) {
        
        if (currentOS) {
            latestOS = YES;
        }
        else
        {
            latestOS = NO;
        }
        
    }];
    
    if(latestOS)
    {
        //NSLog(@"[ NEW STRING ATTRIBUTTES ]");
        NSRange range = NSMakeRange(0, [label.attributedText length]);
        
        NSDictionary *attributes = [label.attributedText attributesAtIndex:0 effectiveRange:&range];
        CGSize boundingBox = [label.text boundingRectWithSize:constraint options: NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        
        size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    }
    else
    {
        NSLog(@"[ OLD STRING ATTRIBUTTES ]");
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        
        size = [label.text sizeWithFont:label.font constrainedToSize:constraint lineBreakMode:label.lineBreakMode];
        
#pragma clang diagnostic pop
        
    }
    
    return size;
}

+ (void)getHeightLabelWithString:(UILabel*)label
                       LabelText:(NSString*)text
                        forWidth:(CGFloat)width
                        forPoint:(CGPoint)point
                   numberOfLines:(NSInteger)numLine
                    DesireHeight:(CGFloat)dHeight
                     limitHeight:(BOOL)isLimit
{
    if ([text length] != 0)
    {
        label.text = text;
        label.numberOfLines = numLine;
        label.lineBreakMode = NSLineBreakByWordWrapping;
        
        
        //41.000000
        //2000.00
        CGSize size = [MAInterface getStringSizeLabel:label customWidth:width customHeight:2000.00];
        
        NSLog(@"==========> HEIGHT: %f",size.height);
        
        if (isLimit)
        {
            if (size.height <= dHeight)
            {
                [label setFrame:CGRectMake(point.x , point.y , size.width , size.height)];
            }
            else
            {
                //41.000000
                [label setFrame:CGRectMake(point.x , point.y , size.width , dHeight)];
            }
            
        }
        else
        {
            [label setFrame:CGRectMake(point.x , point.y , size.width , size.height)];
        }
    }
    
}

+ (void)getWidthLabelWithString:(UILabel*)label LabelText:(NSString*)text forPoint:(CGPoint)point
{
    CGFloat constrainedWidth = 250.0f;
    
    label.text = text;
    label.numberOfLines = 0;
    
    CGSize sizeOfText = [MAInterface getStringSizeLabel:label customWidth:constrainedWidth customHeight:CGFLOAT_MAX];
    label.frame = CGRectMake(point.x,point.y,sizeOfText.width,sizeOfText.height);
    
}


+ (CGSize)maxHeightForTextInRow:(NSString *)rowText width:(float)textWidth FontName:(UIFont*)font;
{
    
    CGSize constrainedSize = CGSizeMake(textWidth, CGFLOAT_MAX);
    
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          font, NSFontAttributeName,
                                          nil];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:rowText attributes:attributesDictionary];
    
    CGRect requiredHeight = [string boundingRectWithSize:constrainedSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    
    if (requiredHeight.size.width > textWidth) {
        requiredHeight = CGRectMake(0, 0, textWidth, requiredHeight.size.height);
    }
    
    return requiredHeight.size;
}

+ (CGRect)getTextRect:(NSString*)text Font:(UIFont*)font
{
    CGSize maximumLabelSize = CGSizeMake(310, CGFLOAT_MAX);
    CGRect textRect = [text boundingRectWithSize:maximumLabelSize
                                         options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                      attributes:@{NSFontAttributeName:font}
                                         context:nil];
    return textRect;
}


+ (NSString*)currentDateToTimeStamp
{
    struct timeval time;
    gettimeofday(&time, NULL);
    long millis = (time.tv_sec * 1000) + (time.tv_usec / 1000);
    
    NSString *strTimestamp = [NSString stringWithFormat:@"%ld",millis];
    
    return strTimestamp;
}

+ (NSString*)timeStampToString:(NSString*)stringUnixDate dateFormat:(NSString*)dateFormat
{
    //yyyy-MM-dd'T'HH:mm:ssZ
    BOOL isStrDate = NO;
    NSString *dateString = nil;
    if ([stringUnixDate length] != 0 && stringUnixDate != nil)
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stringUnixDate doubleValue]/1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        dateString = [dateFormatter stringFromDate:date];
        isStrDate = YES;
    }
    else
    {
        isStrDate = NO;
    }
    
    if (isStrDate)
        return dateString;
    else
        return nil;
}

+ (NSString*)unixTimeToDateString:(NSString*)stringUnixDate dateFormat:(NSString*)dateFormat
{
    //yyyy-MM-dd'T'HH:mm:ssZ
    BOOL isStrDate = NO;
    NSString *dateString = nil;
    if ([stringUnixDate length] != 0 && stringUnixDate != nil)
    {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[stringUnixDate doubleValue]/1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        dateString = [dateFormatter stringFromDate:date];
        isStrDate = YES;
    }
    else
    {
        isStrDate = NO;
    }
    
    if (isStrDate)
        return dateString;
    else
        return nil;
}


NSString *convertDateToPost(NSDate *pastDate)
{
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    
    // Create the current date
    NSDate *currentDate = [[NSDate alloc] init];
    
    // Get conversion to months, days, hours, minutes
    unsigned int unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitMonth;
    
    NSDateComponents *breakdownInfo = [sysCalendar components:unitFlags fromDate:currentDate  toDate:pastDate  options:0];
    
    NSString *intervalString;
    if ([breakdownInfo month]) {
        if (-[breakdownInfo month] > 1)
            intervalString = [NSString stringWithFormat:@"%lumos", (unsigned long)-[breakdownInfo month]];
        else
            intervalString = @"1mo";
    }
    else if ([breakdownInfo day]) {
        if (-[breakdownInfo day] > 1)
            intervalString = [NSString stringWithFormat:@"%ludays", (unsigned long)-[breakdownInfo day]];
        else
            intervalString = @"1day";
    }
    else if ([breakdownInfo hour]) {
        if (-[breakdownInfo hour] > 1)
            intervalString = [NSString stringWithFormat:@"%luhrs", (unsigned long)-[breakdownInfo hour]];
        else
            intervalString = @"1h";
    }
    else {
        if (-[breakdownInfo minute] > 1)
            intervalString = [NSString stringWithFormat:@"%lumins", (unsigned long)-[breakdownInfo minute]];
        else
            intervalString = @"1min";
    }
    
    return intervalString;
}

+ (NSString*)getDatePosted:(NSString*)aStrPostDate dateFormat:(NSString*)dateformat
{
    if (aStrPostDate != nil)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        NSString *currentDateString = aStrPostDate;
        //@"yyyy-MM-dd'T'HH:mm:ssZ"
        [dateFormatter setDateFormat:dateformat];//@"dd-MM-yyyy hh:mm:ss"
        NSDate *adsDate = [dateFormatter dateFromString:currentDateString];
        
        NSString *datePostedAds = convertDateToPost(adsDate);
        return datePostedAds;
    }
    else
    {
        return @"";
    }
}


+ (void)deleteAllFilesInDirectory:(NSString*)directoryName
{
    // Path to the Documents directory
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if ([paths count] > 0)
    {
        NSError *error = nil;
        NSFileManager *fileManager = [NSFileManager defaultManager];
        
        // Print out the path to verify we are in the right place
        NSString *directory = [paths objectAtIndex:0];
        
        // *** uploadVideo ***
        NSString *strOutputFolder = [NSString stringWithFormat:@"/%@/",directoryName];
        NSString *path = [directory stringByAppendingPathComponent:strOutputFolder];
        
        // For each file in the directory, create full path and delete the file
        for (NSString *file in [fileManager contentsOfDirectoryAtPath:path error:&error])
        {
            NSString *filePath = [path stringByAppendingPathComponent:file];
            NSLog(@"File : %@", filePath);
            
            if ([fileManager fileExistsAtPath:filePath]) {
                NSError *error;
                if ([fileManager removeItemAtPath:filePath error:&error] == NO)
                {
                    NSLog(@"=========> [ ERROR DELETING FILE ]");
                }
                else
                {
                    NSLog(@"=========> [ DELETE FILE SUCCESS ]");
                }
            }
            
        }
        
    }
}

+ (NSString*)generateRandomString:(int)num
{
    NSMutableString* string = [NSMutableString stringWithCapacity:num];
    for (int i = 0; i < num; i++) {
        [string appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    return string;
}



#else

+(UIImage*)createIconFontsImage:(NSString*)aIconFonts iconText:(const char*)aIconText iconSize:(CGSize)aSize
{
    UIGraphicsBeginImageContext(aSize);
    
    UILabel *iconFonts = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, aSize.width, aSize.height)] autorelease];
    
    [iconFonts setFont:[UIFont fontWithName:aIconFonts size:aSize.height]];
    [iconFonts setText:[NSString stringWithUTF8String:aIconText]];
    
    // Make the CALayer to draw in our "canvas".
    [[iconFonts layer] renderInContext: UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Set this method to use in tabBarItem
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // Stop the "canvas" from accepting any input.
    UIGraphicsEndImageContext();
    
    // Return the image.
    return image;
}


#endif


@end
