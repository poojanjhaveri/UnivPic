//
//  CG_HomeFeedCell.m
//  cmypic
//
//  Created by Chitvan Gupta on 08/07/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "CG_HomeFeedCell.h"

@interface CG_HomeFeedCell ()

@property (strong, nonatomic) PFObject *currentPhotoObject;
@property (nonatomic) BOOL isLikedByUser;
@property (nonatomic) PFQuery *findLikes; //Later: set this up in shared cache like anypic
@property (nonatomic) PFQuery *findComments; //Later: set this up in shared cache like anypic
@property (nonatomic) PFObject *objectForLike;
@end

@implementation CG_HomeFeedCell

@synthesize userName, userPhoto, feedDate;
@synthesize feedDesc, feedPhoto;
@synthesize commentBtnOutlet, likeBtnOutlet;
@synthesize imageView, isLikedByUser;
@synthesize currentPhotoObject;
@synthesize findComments, findLikes, objectForLike;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        isLikedByUser = FALSE;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)addTag:(id)sender {
    
}

- (IBAction)likeButtonPressed:(id)sender {
    //self.likeBtnOutlet.enabled = NO;
    
    NSString *likeBtnText = likeBtnOutlet.titleLabel.text;
    int numberOfLikes = [likeBtnText intValue];
    
    isLikedByUser = !isLikedByUser;
    
    BOOL liked = isLikedByUser;
    if(liked == true)
    {
        [likeBtnOutlet setSelected:YES];
        numberOfLikes++;
        
        PFObject *addLike = [PFObject objectWithClassName:@"Activity"];
        [addLike setObject:@"Like" forKey:@"type"];
        [addLike setObject:[PFUser currentUser] forKey:@"fromUser"];
        [addLike setObject:currentPhotoObject forKey:@"photo"];
        [addLike setObject:[currentPhotoObject objectForKey:@"user"] forKey:@"toUser"];
        [addLike saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
            if(!error)
            {
                NSLog(@"Hurray! Added a like");
                objectForLike = addLike;
            }
            else
            {
                NSLog(@"Oh no! Can't add a like");
                UIAlertView *unableToLike = [[UIAlertView alloc] initWithTitle:@"No network to like!" message:@"Network failure?" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
                [unableToLike show];
            }
        } ];
    }
    else
    {
        [likeBtnOutlet setSelected:NO];
        if(numberOfLikes>0)
            numberOfLikes--;
        if(objectForLike!=NULL)
        {
            [objectForLike deleteInBackground];
        }
    }
    [likeBtnOutlet setTitle:[NSString stringWithFormat:@"%i" ,numberOfLikes] forState:UIControlStateNormal];
    
    
}

- (IBAction)commentButtonPressed:(id)sender {
    //comment logic: open new view controller
}

-(void) setFeed:(PFObject *) object {
    
    
    currentPhotoObject = object;
 
    //user info
  
    PFObject *user = [object objectForKey:@"user"];
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *obj, NSError *error) {
        
        //user photo
        PFImageView *userPic = [[PFImageView alloc] init];
        //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
        userPic.file = (PFFile *)[obj objectForKey:@"profilePictureSmall"]; //  image from server
        [userPic loadInBackground];
        userPhoto.image = userPic.image;
        
        //        //username
        
        userName.text = [NSString stringWithFormat:@"%@ %@", [obj objectForKey:@"firstName"], [obj objectForKey:@"lastName"]];
        NSLog(@"name %@ ",[obj objectForKey:@"firstName"]);

        
    }];
   
    feedDate.text = [NSString stringWithFormat:@"%@" , object.createdAt]; //needs formatting
    
    imageView = [[PFImageView alloc] init];
    //imageView.image = [UIImage imageNamed:@"..."]; // add placeholder image
    imageView.file = (PFFile *)[object objectForKey:@"image"]; //  image from server
    
    [imageView loadInBackground];

    feedPhoto.image = imageView.image;
    //[feedPhoto ]
    NSString *imageInfo = [object objectForKey:@"imageTitle"];
    NSLog(@"%@", imageInfo);
    feedDesc.text = imageInfo;
    
    //Display check mark if this title was done!
    if([[object objectForKey:@"titleOrTag"] boolValue] == FALSE)
        {
            //Add check mark image, but where?
        }
    
    
    //find number of likes
    findLikes = [PFQuery queryWithClassName:@"Activity"];
    [findLikes whereKey:@"photo" equalTo:object];
    [findLikes whereKey:@"type" equalTo:@"Like"];
    //setup shared cache like anyPic
    if([findLikes hasCachedResult]) 
        [findLikes setCachePolicy:kPFCachePolicyCacheThenNetwork];
    else
        [findLikes setCachePolicy:kPFCachePolicyNetworkOnly]; //Set cache: Use this query result to display who like the pic
    [findLikes findObjectsInBackgroundWithBlock:^(NSArray *likesObjects, NSError *error){
        if(error)
        {
            NSLog(@"Error in finding likes???");
        }
        else{

           // NSLog(@"activity count %i", activityObjects.count);
            //need to: Add like button image
           
            //find if current user likes this photo so that it helps if he hits likebutton
            //May need to be shifted to likebuttonTap
            if(likesObjects.count != 0) //to reduce computation
            for(PFObject *likesFound in likesObjects) 
            {
                if([ [[likesFound objectForKey:@"fromUser"] objectId] isEqualToString:[[PFUser currentUser] objectId] ] )
                {
                    [likeBtnOutlet setSelected:YES];
                    isLikedByUser= true;
                    objectForLike = likesFound; //save this objectid so that its easy to delete it, if needed
                    break;
                }
            }
            NSString *likeBtnLabel = [NSString stringWithFormat:@"%d" , likesObjects.count] ;
            [likeBtnOutlet setTitle:likeBtnLabel forState:UIControlStateNormal ];
        }
                  }];
    
    //find number of comments
    findComments = [PFQuery queryWithClassName:@"Activity"];
    [findComments whereKey:@"photo" equalTo:object];
    [findComments whereKey:@"type" equalTo:@"Comment"];
    [findComments setCachePolicy:kPFCachePolicyNetworkOnly]; //Set cache: Pass this query result to display in commentViewController
    [findComments findObjectsInBackgroundWithBlock:^(NSArray *commentsObjects, NSError *error){
        if(error)
        {
            NSLog(@"Error in finding comments???");
        }
        else{
            // NSLog(@"activity count %i", activityObjects.count);
            //Add comment button image
            NSString *commentBtnLabel = [NSString stringWithFormat:@"%d" , commentsObjects.count] ;
            [commentBtnOutlet setTitle:commentBtnLabel forState:UIControlStateNormal ];
        }
    }];

    
}


@end
