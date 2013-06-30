//
//  PJ_AddItemToCheckListViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/28/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_AddItemToCheckListViewController.h"

@interface PJ_AddItemToCheckListViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation PJ_AddItemToCheckListViewController

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



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.inputField becomeFirstResponder];

}

// Do action when DONE is clicked from the keyword. Send the itemback to the previous list.
-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if (self.completionHandler) {
        self.completionHandler(self.inputField.text);
    }
    return YES;
}




- (IBAction)cancelButtonPressed:(id)sender {
    if (self.completionHandler) {
        self.completionHandler(nil);
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
