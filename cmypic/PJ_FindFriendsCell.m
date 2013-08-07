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


-(void)awakeFromNib
{
    
    [self.followButton setTitle:@"Requested" forState:UIControlStateSelected];
    [self.followButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
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
    
    PFQuery *requeststatus2 = [PFQuery queryWithClassName:@"FriendRelations"];
    [requeststatus2 whereKey:@"toUser" equalTo:[PFUser currentUser]];
    [requeststatus2 whereKey:@"fromUser" equalTo:_user];
    [requeststatus2 whereKey:@"type" equalTo:@"Requested"];
    requeststatus2.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    PFQuery *requestfinalquery = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:requeststatus,requeststatus2,nil]];
    
    requestfinalquery.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    
    
    [requestfinalquery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if(!error)
        {
           if(number>0)
           {
               self.followButton.selected=YES;
                       //     [self.followButton setTitleShadowColor:[UIColor clearColor] forState:UIControlStateSelected];
               self.followButton.userInteractionEnabled=FALSE;
           }
        }
       
    }];
    
}


-(void) setActivity:(PFObject *) object
{
    
   
    _requestuser = [object objectForKey:@"fromUser"];
    
    PFQuery *getuser = [PFUser query];
    [getuser whereKey:@"objectId" equalTo:[_requestuser objectId]];
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
    // So that user does cannot delete his request
    self.followButton.userInteractionEnabled=FALSE;
    
    PFObject *newrelation=[PFObject objectWithClassName:@"FriendRelations"];
    [newrelation setObject:[PFUser currentUser] forKey:@"fromUser"];
    [newrelation setObject:_user forKey:@"toUser"];
    [newrelation setObject:@"Requested" forKey:@"type"];
    [newrelation saveEventually];
}

- (IBAction)friendRequestAccepted:(id)sender {
    
    PFQuery *query=[PFQuery queryWithClassName:@"FriendRelations"];
    [query whereKey:@"fromUser" equalTo:_requestuser];
    [query whereKey:@"toUser" equalTo:[PFUser currentUser]];
    [query whereKey:@"type" equalTo:@"Requested"];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if(!error)
        {
            [object setObject:@"Friend" forKey:@"type"];
            [object saveEventually];
        }
    }];
  
    
}

- (IBAction)friendRequestDecline:(id)sender {
}


@end
