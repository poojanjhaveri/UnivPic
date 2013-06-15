//
//  PJ_SignUpViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/14/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_SignUpViewController.h"

@interface PJ_SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailaddress;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation PJ_SignUpViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)signupdonebuttonpressed:(id)sender {
   
    //1
    PFUser *user = [PFUser user];
    //2
    user.username = self.emailaddress.text;
    user.password = self.password.text;
    user.email=self.emailaddress.text;
    
    //3
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            //The registration was successful, go to the wall
             [self performSegueWithIdentifier:@"SignUpCompleted" sender:@"self"];
            
        } else {
            //Something bad has occurred
            NSString *errorString = [[error userInfo] objectForKey:@"error"];
            UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
            [errorAlertView show];
        }
    }];
    
   
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    [self resignFirstResponder];
}

@end
