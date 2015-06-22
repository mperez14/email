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
#import <CoreData/CoreData.h>

@interface ContactListTableViewController ()

@end

@implementation ContactListTableViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    dataController = [[ContactListDataController alloc] init];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;    //add edit button
    
    // Find out the path of recipes.plist
    /*NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray* firstName = [dict objectForKey:@"firstName"];
    NSArray* lastName = [dict objectForKey:@"lastName"];
    NSArray* email = [dict objectForKey:@"email"];
    NSLog(@"%d",firstName.count);
    for (int i =0; i<firstName.count; i++) {
        NSLog(@"%@",firstName[i]);
        Contact* initialName = [Contact alloc];     //init Contact
        initialName = [initialName initWithFirstName:firstName[i] LastName:lastName[i] Email:email[i]]; //init my contact
        NSLog(@"%@",initialName);
        [dataController.contactList addObject:initialName];    //add contact to list
    }
    [self.tableView reloadData];
     */
}

//implement cancel method to respond to cancelbutton of AddNewContactView
-(void)cancel:(UIStoryboardSegue *)segue{
    //dismiss AddNewContactViewController
    [self dismissViewControllerAnimated:true completion:nil];
}

//Core Data
- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
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
        
        [dataController.contactList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Contacts.plist"];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:(NSString *)plistPath];
        
        //load plist dict
        NSMutableArray *tempFirst = [dictionary objectForKey:@"firstName"];
        NSMutableArray *tempLast = [dictionary objectForKey:@"lastName"];
        NSMutableArray *tempEmail = [dictionary objectForKey:@"email"];
        
        NSLog(@"dict loaded: %@", dictionary);
        NSLog(@"dict loaded FIRST: %@", tempFirst);
        NSLog(@"dict loaded LAST: %@", tempLast);
        NSLog(@"dict loaded EMAIL: %@", tempEmail);
        
        //remove plist object
        [tempFirst removeObjectAtIndex:indexPath.row];
        [tempLast removeObjectAtIndex:indexPath.row];
        [tempEmail removeObjectAtIndex:indexPath.row];
        NSLog(@"dict 2 FIRST: %@", tempFirst);
        NSLog(@"dict 2 LAST: %@", tempLast);
        NSLog(@"dict 2 EMAIL: %@", tempEmail);
        
        //write to new dict
        [dictionary setValue:tempFirst forKey:@"firstName"];
        [dictionary setValue:tempLast forKey:@"lastName"];
        [dictionary setValue:tempEmail forKey:@"email"];
        
        [dictionary writeToFile:plistPath atomically:YES];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
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
