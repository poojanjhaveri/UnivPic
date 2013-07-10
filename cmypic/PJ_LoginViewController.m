//
//  PJ_LoginViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/14/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_LoginViewController.h"

@interface PJ_LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *loginEmailAddress;
@property (weak, nonatomic) IBOutlet UITextField *loginPassword;



@end

@implementation PJ_LoginViewController

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


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:NO];
    if ([PFUser currentUser])
    {
        [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
        // Dont delete this
       
    /*    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]) {
            [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
            
        }
        else
        {
            [self performSegueWithIdentifier:@"LoginToFeed" sender:self];
        }*/

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButtonPressed:(id)sender {
    
    
    
    if([PFUser logInWithUsername:self.loginEmailAddress.text password:self.loginPassword.text])
    {
        
        PFUser *currentUser = [PFUser currentUser];
        if (![[currentUser objectForKey:@"emailVerified"] boolValue])
        {
            UIAlertView *errorAlertView1 = [[UIAlertView alloc] initWithTitle:@"Verify email address" message:@"Please verify by clicking on the link in the mail sent to you while signing up" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView1 show];
            [PFUser logOut];
        }
        else{
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]) {
                [self performSegueWithIdentifier:@"LoginSuccessful" sender:self];
               
            }
            else
            {
            [self performSegueWithIdentifier:@"LoginToFeed" sender:self];
            }
        }
        } else {
            //Something bad has ocurred
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please Check your credenntials" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

@end
