//
//  PJ_MoreMainMenuViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 7/20/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_MoreMainMenuViewController.h"
#import <Parse/Parse.h>
#import "PJ_LoginViewController.h"

@interface PJ_MoreMainMenuViewController ()

@end

@implementation PJ_MoreMainMenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Works only in iOS 7
    if([[[UIDevice currentDevice] systemVersion] floatValue]>= 7.0)
    {
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.6 green:0.0 blue:0.0 alpha:1]];
    }
    
    
    [self.navigationController.navigationBar setTintColor:[UIColor yellowColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor yellowColor], NSForegroundColorAttributeName,
                                                                     nil ]];
    


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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                    
                    break;
                    
                default:
                    break;
            }
            
            
            
            break;
            
        case 1:
            
            switch (indexPath.row) {
                case 0:
                    
                    break;
                    
                case 1:
                    
                    break;
                    
                case 2:
                {
                    [PFUser logOut];
                    
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    PJ_LoginViewController *viewController = ( PJ_LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"initialstart"];
                    [self presentViewController:viewController animated:YES completion:nil];
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
            
        default:
            break;
    }
    
    
    
    
    if( indexPath.section==1 && indexPath.row==2)
    {
        
        
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
