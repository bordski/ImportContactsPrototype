//
//  LBRegisterValidationView.m
//  Blumr
//
//  Created by Adrich on 10/8/14.
//  Copyright (c) 2014 blumoon. All rights reserved.
//

#import "LBRegisterValidationView.h"
#import "LBIconFonts.h"
#import "MAInterface.h"

@implementation LBRegisterValidationView

@synthesize signUp_email_taken;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)titleError:(NSString*)aTitle hintText:(NSString*)aHint useSingleLine:(BOOL)aLine;
{
    self.title_label.text = aTitle;
    
    if (!aLine)
    {
        self.hint_label_description.hidden = NO;
        self.hint_label_description.text = [NSString stringWithFormat:@"Hint: %@",aHint];
        self.hint_label_desc_single_line.hidden = YES;
    }
    else
    {
        self.hint_label_desc_single_line.hidden = NO;
        self.hint_label_desc_single_line.text = [NSString stringWithFormat:@"Hint: %@",aHint];
        self.hint_label_description.hidden = YES;
    }
    
    
//    [MAInterface convertToIconFont:self.oops_label iconText:lb_icon_oops_roboto fontSize:30.0f];
    // note: change to actual blumr font light
    
    self.signUp_email_taken = NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
