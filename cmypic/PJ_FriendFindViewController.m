//
//  PJ_FriendFindViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/30/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_FriendFindViewController.h"
#import <Parse/Parse.h>
#import "PJ_FindFriendsCell.h"

@interface PJ_FriendFindViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property(strong,nonatomic) NSArray *foundUsers;
@end

@implementation PJ_FriendFindViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    PFQuery *query1=[PFUser query];
    [query1 whereKey:@"firstName" containsString:searchBar.text];
    query1.cachePolicy=kPFCachePolicyNetworkElseCache;
    
    
    PFQuery *querylower1=[PFUser query];
    [querylower1 whereKey:@"firstName" containsString:[searchBar.text lowercaseString]];
    querylower1.cachePolicy=kPFCachePolicyNetworkElseCache;
    
    PFQuery *query2=[PFUser query];
    [query2 whereKey:@"lastName" containsString:searchBar.text];
    query2.cachePolicy=kPFCachePolicyNetworkElseCache;
    
    PFQuery *querylower2=[PFUser query];
    [querylower2 whereKey:@"lastName" containsString:[searchBar.text lowercaseString]];
    querylower2.cachePolicy=kPFCachePolicyNetworkElseCache;
    
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:query1,query2,nil]];
    query.cachePolicy=kPFCachePolicyNetworkElseCache;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error)
        {
            
            if(objects.count==0)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No Users found" message:@"No users with this search found. Please Try again" delegate:@"self" cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
            }
            else
            {
            _foundUsers=objects;
            NSLog(@"count of searched users is %d",_foundUsers.count);
            [self.tableView reloadData];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Poor Internet Connectivity" message:@"Please Check your internet connection" delegate:@"self" cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:NO];
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _foundUsers=[[NSMutableArray alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return _foundUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_foundUsers.count==0)
    {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text=[_foundUsers objectAtIndex:indexPath.row];
    return cell;
    }
    else
    {
    NSString *cellIdentifier = @"FriendCell";
    PJ_FindFriendsCell *cell =[tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setUser:(PFUser*)[_foundUsers objectAtIndex:indexPath.row]];
    
    
    return cell;
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
