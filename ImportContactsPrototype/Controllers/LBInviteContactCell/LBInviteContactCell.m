//
//  LBInviteContactCell.m
//  Blumr
//
//  Created by Adrich on 1/12/15.
//  Copyright (c) 2015 Let's Blum It!. All rights reserved.
//

#import "LBInviteContactCell.h"
#import "MAInterface.h"
#import "BLConstant.h"
#import "LBIconFonts.h"

@implementation LBInviteContactCell

@synthesize contactModel = _contactModel;

- (void)setContactModel:(ContactModel *)contactModel {
    [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_on fontSize:26.0f];
    if (contactModel == nil) {
        NSLog(@"contact model cannot be nil");
        
        return;
    }
    self.iconf_check.textColor = blumr_color_blue;
    _contactModel = contactModel;
    if (self.contactModel.photoData.length > 0) {
        self.imageView_person.image = [UIImage imageWithData:self.contactModel.photoData];
    } else {
#warning do the default image thing
    }

    self.label_person_name.text = self.contactModel.contactRepresentation;
    
    if (self.contactModel.isSelected == TRUE) {
        [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_on fontSize:26.0f];
    } else {
        [MAInterface convertToIconFont:self.iconf_check iconText:blumrcon_checkbox_1_off fontSize:26.0f];
    }
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
