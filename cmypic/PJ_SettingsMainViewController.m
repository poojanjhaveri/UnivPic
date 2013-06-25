//
//  PJ_SettingsMainViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/25/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_SettingsMainViewController.h"
#import <Parse/Parse.h>
#import "PJ_LoginViewController.h"

@interface PJ_SettingsMainViewController ()

@end

@implementation PJ_SettingsMainViewController

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
	// Do any additional setup after loading the view.
}

- (IBAction)logOutPressed:(id)sender {
    
    [PFUser logOut];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     PJ_LoginViewController *viewController = ( PJ_LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"initialstart"];
    [self presentViewController:viewController animated:YES completion:nil];
        
 
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
