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
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Contacts.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            NSLog(@"Error Loading");
            plistPath = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        }
        
        
        
        contactList = [[NSMutableArray alloc] init];
        
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        
        // Load the file content and read the data into arrays
        //NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
        NSArray* firstName = [dict objectForKey:@"firstName"];
        NSArray* lastName = [dict objectForKey:@"lastName"];
        NSArray* email = [dict objectForKey:@"email"];
        for (int i =0; i<firstName.count; i++) {
            Contact* initialName = [Contact alloc];     //init Contact
            initialName = [initialName initWithFirstName:firstName[i] LastName:lastName[i] Email:email[i]]; //init my contact
            [contactList addObject:initialName];    //add contact to list
        }
        
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
    //save to plist
    /*NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    [dict setValue:newContact.first forKey:@"firstName"];
    [dict setValue:newContact.last forKey:@"lastName"];
    [dict setValue:newContact.email forKey:@"email"];

    NSLog(@"%@ %@, %@", newContact.first, newContact.last, newContact.email);
    //NSArray* lastName = [dict objectForKey:@"lastName"];
    //NSArray* email = [dict objectForKey:@"email"];
    [dict writeToFile:path atomically:YES];
    */
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //NSMutableArray *contentArray= [[NSMutableArray alloc]init];
    NSMutableArray *firstNameArray= [[NSMutableArray alloc]init];
    NSMutableArray *lastNameArray= [[NSMutableArray alloc]init];
    NSMutableArray *emailArray= [[NSMutableArray alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    
    
    
    if (![fileManager fileExistsAtPath: plistFilePath])
    {
        NSLog(@"File does not exist");
        
        // If the file doesn’t exist, create an empty plist file
        plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
        //NSLog(@"path is %@",plistFilePath);
        
    }
    else{
        NSLog(@"File exists, Get data if anything stored");
    }
    NSLog(@"dict loaded: %@", dict);
    NSLog(@"dict loaded FIRST: %@", [dict objectForKey:@"firstName"]);
    NSLog(@"dict loaded LAST: %@", [dict objectForKey:@"lastName"]);
    NSLog(@"dict loaded EMAIL: %@", [dict objectForKey:@"email"]);
    NSLog(@"# in firstname: %d", [[dict objectForKey:@"firstName"] count]);
    
    for(int i=0; i<[[dict objectForKey:@"firstName"] count]; i++){
        //extract data
        NSString *first = [dict objectForKey:@"firstName"][i];
        NSString *last = [dict objectForKey:@"lastName"][i];
        NSString *email = [dict objectForKey:@"email"][i];
        //add to array
        [firstNameArray addObject:first];
        [lastNameArray addObject:last];
        [emailArray addObject:email];
    }
    
    //add stuff to array
    //NSLog(@"array: %@", contentArray);
    [firstNameArray addObject:newContact.first];
    [lastNameArray addObject:newContact.last];
    [emailArray addObject:newContact.email];
    
    //add to dictionary
    [dict setValue:firstNameArray forKey:@"firstName"];
    [dict setValue:lastNameArray forKey:@"lastName"];
    [dict setValue:emailArray forKey:@"email"];
    NSLog(@"final Dict: %@", dict);
    
    
    if([dict writeToFile:plistFilePath atomically:YES]){
        NSLog(@"Yeah! written successfully");
    }
    else{
        NSLog(@"Boo! Not written to plist");
    }

    
    [contactList addObject:newContact];
}

-(void)deleteContact:(NSIndexPath *)indexPath{
    //[contactList removeObjectAtIndex:indexPath.row];
}



@end
