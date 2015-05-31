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
        contactList = [[NSMutableArray alloc] init];    //init contactList
        Contact* initialName = [Contact alloc];     //init Contact
        initialName = [initialName initWithFirstName:@"Matt" LastName:@"Perez" Email:@"perez.matthew13@gmail.com"]; //init my contact
        [contactList addObject:initialName];    //add contact to list
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
    return [contactList count];
}

//implement return contact
-(Contact *)contactAtIndex:(NSUInteger)index{
    return [contactList objectAtIndex:index];
}

-(void)addNewContact:(Contact *)newContact{
    [contactList addObject:newContact];
}

@end
