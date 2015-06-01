//
//  ContactListDataController.h
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Contact.h"

@interface ContactListDataController : NSObject

//property to keep track of list of contacts
@property (nonatomic, copy) NSMutableArray* contactList;


//methods

-(NSUInteger) countOfContactList;   //num of elements in contactList
-(Contact*) contactAtIndex:(NSUInteger) index;  //element number in list (returns specfic contact)
-(void) addNewContact:(Contact*) newContact;    //add a new Contact to the list
-(void) deleteContact:(NSIndexPath *) indexPath;
//(return type)         //parameter type    //parameter input

@end
