//
//  ContactListDataController.m
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import "ContactListDataController.h"

@implementation ContactListDataController
@synthesize contactList;

-(id)init{
    self = [super init];
    if (self) {
        contactList = [[NSMutableArray alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        
        // Load the file content and read the data into arrays
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        NSArray* firstName = [dict objectForKey:@"firstName"];
        NSArray* lastName = [dict objectForKey:@"lastName"];
        NSArray* email = [dict objectForKey:@"email"];
        for (int i =0; i<firstName.count; i++) {
            Contact* initialName = [Contact alloc];     //init Contact
            initialName = [initialName initWithFirstName:firstName[i] LastName:lastName[i] Email:email[i]]; //init my contact
            [contactList addObject:initialName];    //add contact to list
        }
        
        /*
        contactList = [[NSMutableArray alloc] init];    //init contactList
        Contact* initialName = [Contact alloc];     //init Contact
        initialName = [initialName initWithFirstName:@"Matt" LastName:@"Perez" Email:@"perez.matthew13@gmail.com"]; //init my contact
        [contactList addObject:initialName];    //add contact to list
        */
        /*
        Contact* initialNameTwo = [initialName initWithFirstName:@"Lucy" LastName:@"Fakeperson" Email:@"imsofake@hotmail.com"]; //init my contact
        [contactList addObject:initialNameTwo];*/
        return self;
    }
    else{
        return nil;
    }
}

//implementation of count method
-(NSUInteger)countOfContactList{
    //return number of contacts in list
    //NSLog(@"ContactList Size: %d", [contactList count]);
    return [contactList count];
}

//implement return contact
-(Contact *)contactAtIndex:(NSUInteger)index{
    return [contactList objectAtIndex:index];
}

-(void)addNewContact:(Contact *)newContact{
    [contactList addObject:newContact];
}

-(void)deleteContact:(NSIndexPath *)indexPath{
    //[contactList removeObjectAtIndex:indexPath.row];
}



@end
