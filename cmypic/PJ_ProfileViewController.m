//
//  PJ_ProfileViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/12/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ProfileViewController.h"
#import <Parse/Parse.h>

@interface PJ_ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *ClassOF;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PJ_ProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _displayName.text=[NSString stringWithFormat:@"%@ %@",[[PFUser currentUser] objectForKey:@"firstName"],[[PFUser currentUser] objectForKey:@"lastName"]];
    _ClassOF.text=[[PFUser currentUser] objectForKey:@"ClassOf"];
    self.imageView.image=[[PFUser currentUser]objectForKey:@"profilePictureSmall"];
    

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
