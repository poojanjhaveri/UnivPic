//
//  CG_HomeFeedCell.h
//  cmypic
//
//  Created by Chitvan Gupta on 08/07/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CG_HomeFeedCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *feedDate;

@property (weak, nonatomic) IBOutlet UIImageView *feedPhoto;
@property (weak, nonatomic) IBOutlet UILabel *feedDesc;
@property (weak, nonatomic) IBOutlet UIButton *commentBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *likeBtnOutlet;

@property (strong, nonatomic) PFImageView *imageView;

- (IBAction)addTag:(id)sender;
- (IBAction)likeButtonPressed:(id)sender;
- (IBAction)commentButtonPressed:(id)sender;
-(void) setFeed:(PFObject *) object;

@end
