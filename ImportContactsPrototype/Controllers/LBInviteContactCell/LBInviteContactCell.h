//
//  LBInviteContactCell.h
//  Blumr
//
//  Created by Adrich on 1/12/15.
//  Copyright (c) 2015 Let's Blum It!. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ContactModel.h"

@interface LBInviteContactCell : UITableViewCell

@property (nonatomic, strong) ContactModel *contactModel;

@property (nonatomic, strong) IBOutlet UIImageView* imageView_person;
@property (nonatomic, strong) IBOutlet UILabel *label_person_name;

@property (nonatomic, strong) IBOutlet UILabel *iconf_check;


@end
