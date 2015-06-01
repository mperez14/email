//
//  ContactListTableViewController.m
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import "ContactListTableViewController.h"
#import "ContactDetailTableViewController.h"
#import "AddNewTableViewController.h"

@interface ContactListTableViewController ()

@end

@implementation ContactListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataController = [[ContactListDataController alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;    //add edit button
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

//implement cancel method to respond to cancelbutton of AddNewContactView
-(void)cancel:(UIStoryboardSegue *)segue{
    //dismiss AddNewContactViewController
    [self dismissViewControllerAnimated:true completion:nil];
}

-(void)done:(UIStoryboardSegue *)segue{
    AddNewTableViewController* addNewController = [segue sourceViewController];
    Contact* newContact = [addNewController contact];
    [dataController addNewContact:newContact];
    
    //refresh tableView and list
    [self.tableView reloadData];
    //dismiss addNewViewController
    [self dismissViewControllerAnimated:true completion:nil];
}

//prepare seque to pass contact info that was selected to the ContactDetailViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowDetailsSegue"]){//segue points to ContactDetailViewController
        ContactDetailTableViewController* destination=[segue destinationViewController];
        
        //get selected index
        NSInteger index = [self.tableView indexPathForSelectedRow].row;
        Contact* selectedContact = [dataController contactAtIndex:index]; //get selected contact
        //assign selected contact to the contact property to the destination
        [destination setContact:selectedContact];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section = number of contacts
    return [dataController countOfContactList];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //1. Get contact object at particular index
    Contact* cellContact = [dataController contactAtIndex:indexPath.row];
    
    //2. Get text label in cell
    UILabel* cellTitle = [cell textLabel];
    //assign lastname from contact to cellTitle
    [cellTitle setText:[cellContact last]];
    //assign firstname to detail label
    
    UILabel* cellDetail = [cell detailTextLabel];
    [cellDetail setText:[cellContact first]];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSMutableArray* list = [[ContactListDataController alloc] contactList];
        [list removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   */
}



/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
