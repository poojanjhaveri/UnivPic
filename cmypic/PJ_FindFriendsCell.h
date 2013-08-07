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
@property (strong, nonatomic) IBOutlet UIButton *followButton;
@property (strong, nonatomic) IBOutlet UILabel *displayName;
@property (strong, nonatomic) IBOutlet UIImageView *displayImage;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFUser *requestuser;

-(void) setUser:(PFUser *) object;
-(void) setActivity:(PFObject *) object;
@end
