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
    
    //index
    //add contact to contactDict (INDEX)
    NSString *initial = [newContact.last substringToIndex:1];    //what letter to save to (initial)
    [initial uppercaseString];  //capitalize initial
    NSMutableArray *tempArray = [[NSMutableArray alloc] init]; //extract data
    for(int i=0;i<[[dataController.contactDict objectForKey:initial] count]; i++){
        tempArray = [dataController.contactDict objectForKey:initial];    //get last name in dict for specfic initial
        
        
        // NSLog(@"before dict: %@", dataController.contactDict);
        [tempArray addObject:newContact];  //add array to contactDict (update with new contact
        [dataController.contactDict setObject:tempArray forKey:initial];    //add array to dict
        
        
        // NSLog(@"after dict: %@", dataController.contactDict);
        
        //    Contact *person = [[Contact alloc] init];
        //    NSArray *array= [dataController.contactDict objectForKey:initial];
        //    NSLog(@"array: %@", array);
        //    for(int i=0; i<[[dataController.contactDict objectForKey:initial] count]; i++){
        //        person = array[i];
        //        NSLog(@"contactDict at initial saved: %@", person.last);
        //    }
        
        //refresh tableView and list
        [self.tableView reloadData];
        //dismiss addNewViewController
        [self dismissViewControllerAnimated:true completion:nil];
    }
}


//prepare seque to pass contact info that was selected to the ContactDetailViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"ShowDetailsSegue"]){//segue points to ContactDetailViewController
        ContactDetailTableViewController* destination=[segue destinationViewController];
        //get selected index
        
        //(Index) Get Correct Person
        NSIndexPath *path =[self.tableView indexPathForSelectedRow];    //return path
        //use path to get name of contact
        NSString *sectionTitle = [dataController.contactTitles objectAtIndex:path.section];    //get contactTitle (which letter?)
        NSArray *sectionContact = [dataController.contactDict objectForKey:sectionTitle];   //get contacts from that letter in dictionary
        Contact *person = [sectionContact objectAtIndex:path.row];
        NSLog(@"index is: %@", person.first);
        Contact* selectedContact = [dataController contactAtIndexName:person.first usingLast:person.last usingEmail:person.email]; //get selected contact (INDEX)
    
        
        //NSInteger index = [self.tableView indexPathForSelectedRow].row; //returns number in row   (OLD)
        //Contact* selectedContact = [dataController contactAtIndex:index]; //get selected contact  (OLD)
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
    //return 1;
    //index
    return [dataController.contactTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section = number of contacts
    //return [dataController countOfContactList];
    
    //index
    NSString *sectionTitle = [dataController.contactTitles objectAtIndex:section];
    NSArray *sectionAnimals = [dataController.contactDict objectForKey:sectionTitle];
    return [sectionAnimals count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    /*
    Contact* cellContact = [dataController contactAtIndex:indexPath.row];
    //1. Get contact object at particular index
    
    //2. Get text label in cell
    UILabel* cellTitle = [cell textLabel];
    //assign lastname from contact to cellTitle
    [cellTitle setText:[cellContact last]];
    //assign firstname to detail label
    
    UILabel* cellDetail = [cell detailTextLabel];
    [cellDetail setText:[cellContact first]];
    */
    
    //index
    NSString *sectionTitle = [dataController.contactTitles objectAtIndex:indexPath.section];    //get contactTitle (which letter?)
    NSArray *sectionContact = [dataController.contactDict objectForKey:sectionTitle];   //get contacts from that letter in dictionary
    Contact *person = [sectionContact objectAtIndex:indexPath.row];    //get person from dictionary
    //NSLog(@"%@", person.first);
    NSString *name = [NSString stringWithFormat:@"%@ %@", person.first, person.last];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = nil;
    
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
        
        //INDEX (Remove object)
        //remove from contactDict
//        for(int i =0;i< [dataController.contactList count];i++){
//            Contact *testguy = dataController.contactList[i];
//            NSLog(@"before delete: %@ %@", testguy.first, testguy.last);
//        }
        
        NSIndexPath *path =[self.tableView indexPathForSelectedRow];    //return path
        //use path to get name of contact
        NSString *sectionTitle = [dataController.contactTitles objectAtIndex:indexPath.section];    //get contactTitle (which letter?)
        //NSLog(@"section title: %@", sectionTitle);
        NSMutableArray *sectionContact = [dataController.contactDict objectForKey:sectionTitle];   //get contacts from that letter in dictionary
        Contact *person = [sectionContact objectAtIndex:path.row];
        //NSLog(@"index to delete is: %@ %@", person.first, person.last);
        
        [sectionContact removeObjectAtIndex:indexPath.row];
        [dataController.contactDict setObject:sectionContact forKey:sectionTitle];
        
        [dataController.contactList removeObject:person];   //remove contact from contactList
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
//        for(int i =0;i< [dataController.contactList count];i++){
//            Contact *testguy = dataController.contactList[i];
//            NSLog(@"after delete: %@ %@", testguy.first, testguy.last);
//        }
        
        //plist deletion
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Contacts.plist"];
        //NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:(NSString *)plistPath];
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        //load plist dict
        NSMutableArray *tempFirst = [dictionary objectForKey:@"firstName"];
        NSMutableArray *tempLast = [dictionary objectForKey:@"lastName"];
        NSMutableArray *tempEmail = [dictionary objectForKey:@"email"];
        
        //NSLog(@"dict loaded: %@", dictionary);
        //NSLog(@"dict loaded FIRST: %@", tempFirst);
        //NSLog(@"dict loaded LAST: %@", tempLast);
        //NSLog(@"dict loaded EMAIL: %@", tempEmail);
        
       /* //remove plist object from temp array
        [tempFirst removeObjectAtIndex:indexPath.row];
        [tempLast removeObjectAtIndex:indexPath.row];
        [tempEmail removeObjectAtIndex:indexPath.row];
        */
        
        //remove plist object from temp array
        [tempFirst removeObject:person.first];
        [tempLast removeObject:person.last];
        [tempEmail removeObject:person.email];
        
        //NSLog(@"dict 2 FIRST: %@", tempFirst);
        //NSLog(@"dict 2 LAST: %@", tempLast);
        //NSLog(@"dict 2 EMAIL: %@", tempEmail);
        
        //write to new dict
        [dictionary setValue:tempFirst forKey:@"firstName"];
        [dictionary setValue:tempLast forKey:@"lastName"];
        [dictionary setValue:tempEmail forKey:@"email"];
        
        [dictionary writeToFile:plistPath atomically:YES];  //write to plist
        for(int i=0;i<3;i++){
            NSString *first = [dictionary objectForKey:@"firstName"];
            NSString *last = [dictionary objectForKey:@"lastName"];
            NSLog(@"dictionary after: %@ %@", first, last);
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


//index
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [dataController.contactTitles objectAtIndex:section];
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