//
//  ContactListTableViewController.h
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactListDataController.h"

@interface ContactListTableViewController : UITableViewController
//create instance of ContactListDataController
{
    ContactListDataController* dataController;
    
}

-(IBAction)cancel:(UIStoryboardSegue*) segue;
-(IBAction)done:(UIStoryboardSegue*) segue;
@end
