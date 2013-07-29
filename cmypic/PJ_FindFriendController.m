//
//  PJ_FindFriendsViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/24/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_FindFriendController.h"
#import "PJ_FindFriendsCell.h"

@interface PJ_FindFriendController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation PJ_FindFriendController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         
        // Custom initialization
    }
    return self;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    
    self.paginationEnabled=YES;
	// Do any additional setup after loading the view.
}

/*
- (PFQuery *)queryForTable {
    
    NSLog(@"x%@x",_searchBar.text);
    PFQuery *query = [PFUser query];
  /*  [query whereKey:@"username" notEqualTo:[[PFUser currentUser] objectForKey:@"username"]];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:@"createdAt"];
    
    return nil;
}
*/



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
