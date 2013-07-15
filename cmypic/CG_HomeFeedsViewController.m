//
//  CG_HomeFeedsViewController.m
//  cmypic
//
//  Created by Chitvan Gupta on 13/07/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "CG_HomeFeedsViewController.h"
#import "CG_HomeFeedCell.h"

@interface CG_HomeFeedsViewController ()

@end

@implementation CG_HomeFeedsViewController

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithClassName:@"Foo"];
    self = [super initWithCoder:aDecoder];
    if (self) {
        // The className to query on
        //self.className = @"Foo";
        
        // The key of the PFObject to display in the label of the default cell style
        //self.keyToDisplay = @"text";
        
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 25;
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

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return 2;
//}


-(PFQuery *) queryForTable{
    
    PFQuery *query = [PFQuery queryWithClassName:@"Photo"];
    [query whereKey:@"publicOrPrivate" equalTo:[NSNumber numberWithBool:YES]];
    
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByDescending:@"createdAt"];

    return query;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object{
    
    NSString *cellIdentifier = @"FeedCell";

    CG_HomeFeedCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setFeed:object];
    


  
    return cell;
}

@end
