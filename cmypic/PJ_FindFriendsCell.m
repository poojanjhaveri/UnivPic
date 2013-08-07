//
//  PJ_FindFriendsCell.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/23/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_FindFriendsCell.h"


@implementation PJ_FindFriendsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
       
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    

    // Configure the view for the selected state
}

-(void) setUser:(PFUser *) object {
    
    //user info
  
    _user = object;
    
    PFImageView *userPic = [[PFImageView alloc] init];
    //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
    userPic.file = (PFFile *)[_user objectForKey:@"profilePictureSmall"]; //  image from server
    [userPic loadInBackground];
    _displayImage.image = userPic.image;
    
    _displayName.text = [NSString stringWithFormat:@"%@ %@", [_user objectForKey:@"firstName"], [_user objectForKey:@"lastName"]];
    
    PFQuery *requeststatus = [PFQuery queryWithClassName:@"FriendRelations"];
    [requeststatus whereKey:@"fromUser" equalTo:[PFUser currentUser]];
    [requeststatus whereKey:@"toUser" equalTo:_user];
    [requeststatus whereKey:@"type" equalTo:@"Requested"];
     requeststatus.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    [requeststatus countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if(!error)
        {
           if(number>0)
           {
               self.followButton.selected=YES;
               
               [self.followButton setTitle:@"Requested" forState:UIControlStateSelected];
               [self.followButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
               self.followButton.userInteractionEnabled=FALSE;
           }
        }
       
    }];
    
}


-(void) setActivity:(PFObject *) object
{
    _user = [object objectForKey:@"fromUser"];
    
    PFQuery *getuser = [PFUser query];
    [getuser whereKey:@"objectId" equalTo:[_user objectId]];
    PFObject *fromUser = [getuser getFirstObject];
    
    PFImageView *userPic = [[PFImageView alloc] init];
    //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
    userPic.file = (PFFile *)[fromUser objectForKey:@"profilePictureSmall"]; //  image from server
    [userPic loadInBackground];
    _displayImage.image = userPic.image;
    
    _displayName.text = [NSString stringWithFormat:@"%@ %@", [fromUser objectForKey:@"firstName"], [fromUser objectForKey:@"lastName"]];
}

- (IBAction)FriendButtonClicked:(id)sender {
    
    self.followButton.selected=YES;
    
    [self.followButton setTitle:@"Requested" forState:UIControlStateSelected];
    [self.followButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
    
    // So that user does cannot delete his request
    self.followButton.userInteractionEnabled=FALSE;
    
    PFObject *newrelation=[PFObject objectWithClassName:@"FriendRelations"];
    [newrelation setObject:[PFUser currentUser] forKey:@"fromUser"];
    [newrelation setObject:_user forKey:@"toUser"];
    [newrelation setObject:@"Requested" forKey:@"type"];
    [newrelation saveEventually];
}

@end
