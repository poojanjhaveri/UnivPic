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
  
    PFObject *user = object;
/*    [user fetchInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
   
 //   [user fetchIfNeededInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
        
        NSLog(@"yo here");
        if(error)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Please check your internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
        
        //user photo
        PFImageView *userPic = [[PFImageView alloc] init];
        //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
        userPic.file = (PFFile *)[obj objectForKey:@"profilePictureSmall"]; //  image from server
        [userPic loadInBackground];
        _displayImage.image = userPic.image;
        
        //username
        
        _displayName.text = [NSString stringWithFormat:@"%@ %@", [obj objectForKey:@"firstName"], [obj objectForKey:@"lastName"]];
        }
    }];*/
    
    PFImageView *userPic = [[PFImageView alloc] init];
    //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
    userPic.file = (PFFile *)[user objectForKey:@"profilePictureSmall"]; //  image from server
    [userPic loadInBackground];
    _displayImage.image = userPic.image;
    
    
    _displayName.text = [NSString stringWithFormat:@"%@ %@", [user objectForKey:@"firstName"], [user objectForKey:@"lastName"]];
    
    
}

@end
