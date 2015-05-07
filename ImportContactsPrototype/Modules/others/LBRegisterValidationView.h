//
//  LBRegisterValidationView.h
//  Blumr
//
//  Created by Adrich on 10/8/14.
//  Copyright (c) 2014 blumoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBRegisterValidationView : UIView

@property (nonatomic, strong) IBOutlet UILabel *oops_label;
@property (nonatomic, strong) IBOutlet UILabel *title_label;
@property (nonatomic, strong) IBOutlet UILabel *hint_label;
@property (nonatomic, strong) IBOutlet UILabel *hint_label_description;
@property (nonatomic, strong) IBOutlet UILabel *hint_label_desc_single_line;
@property (nonatomic, strong) IBOutlet UILabel *right_side_logo_label;

@property (nonatomic, assign) BOOL signUp_email_taken;

-(void)titleError:(NSString*)aTitle hintText:(NSString*)aHint useSingleLine:(BOOL)aLine;

@end
