//
//  PJ_ProfieEditViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/15/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_ProfieEditViewController.h"

@interface PJ_ProfieEditViewController ()
@property(nonatomic,weak)IBOutlet UITableView *tableView;
@end

@implementation PJ_ProfieEditViewController

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
    self.navigationItem.hidesBackButton=YES;
    // Do any additional setup after loading the view.
}

- (IBAction)saveButtonPressed:(id)sender {
    NSLog(@"%hhd",[[NSUserDefaults standardUserDefaults] boolForKey:@"wasLaunchedBefore"]);
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"wasLaunchedBefore"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logOutPressed:(id)sender {
    [PFUser logOut];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

@end
