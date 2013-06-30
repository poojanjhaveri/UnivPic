//
//  PJ_CheckListMainViewController.m
//  cmypic
//
//  Created by Poojan Jhaveri on 6/25/13.
//  Copyright (c) 2013 Poojan Jhaveri. All rights reserved.
//

#import "PJ_CheckListMainViewController.h"
#import "PJ_ChecklistModel.h"
#import "PJ_AddItemToCheckListViewController.h"

@interface PJ_CheckListMainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) PJ_ChecklistModel *model;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation PJ_CheckListMainViewController

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
    self.model=[PJ_ChecklistModel sharedModel];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    
    /*
     UISegmentedControl *statFilter = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"To be Created", @"Stored", nil]];
     statFilter.frame=CGRectMake(0, 0, 100, 100);
     [statFilter sizeToFit];
     //[statFilter sizeToFit];
     self.navigationItem.titleView = statFilter;
     */
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PJ_AddItemToCheckListViewController *inputVC = segue.destinationViewController;
    // completion block
    inputVC.completionHandler = ^(NSString *text) {
        if (text != nil) {
            NSUInteger answerIndex = [self.model addAnswer:text];
            NSIndexPath *indexPath = [NSIndexPath
                                      indexPathForRow:answerIndex inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}



#pragma mark - UIButtons change


- (IBAction)segmentControlChanged:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    if(segment.selectedSegmentIndex==0)
    {
        self.addButton.enabled=YES;
    }
    else{
        self.addButton.enabled=NO;
    }
}


- (IBAction)addButtonPressed:(id)sender {
}

- (IBAction)editButtonPressed:(id)sender {
    
    if(self.editing)
        
    {
        self.editButton.title=@"Edit";
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
    }
    
    else
        
    {
        [super setEditing:YES animated:YES];
        self.editButton.title=@"Done";
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        
    }
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
    return [self.model.thingstodo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text=[self.model.thingstodo objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.shouldIndentWhileEditing = NO;
    return cell;
}



// Override to support conditional editing of the table view.
/*
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //    [self.model removeAnswerAtIndex:indexPath.row];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}




#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}






- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
