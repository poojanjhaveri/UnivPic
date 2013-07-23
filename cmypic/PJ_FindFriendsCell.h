//
//  PJ_FindFriendsCell.h
//  cmypic
//
//  Created by Poojan Jhaveri on 7/23/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PJ_FindFriendsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UIImageView *displayImage;


-(void) setUser:(PFUser *) object;
@end
