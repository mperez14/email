//
//  ContactListDataController.m
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import "ContactListDataController.h"

@implementation ContactListDataController
@synthesize contactList, contactDict, contactTitles;

-(id)init{
    self = [super init];
    if (self) {
        //Load ContactList from plist
        NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Contacts.plist"];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
        {
            NSLog(@"Error loading");
            //plistPath = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
        }
        
       
        contactList = [[NSMutableArray alloc] init];
        contactTitles = [[NSMutableArray alloc] init];
        contactDict = [[NSMutableDictionary alloc] init];
        
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSLog(@"dict load: %@", dict);
        NSArray* firstName = [dict objectForKey:@"firstName"];
        NSArray* lastName = [dict objectForKey:@"lastName"];
        NSArray* email = [dict objectForKey:@"email"];
        //NSLog(@"%@ %@, %@", firstName, lastName, email);
        for (int i =0; i<firstName.count; i++) {
            Contact* initialName = [Contact alloc];     //init Contact
            initialName = [initialName initWithFirstName:firstName[i] LastName:lastName[i] Email:email[i]]; //init my contact
            [contactList addObject:initialName];    //add contact to list
        }
       
        
        //LOAD INDEX PLIST. everytime list is loaded. Create dictionary
        for (char a = 'A'; a <= 'Z'; a++){  //go thru alphabe
            NSMutableArray *tempArray = [[NSMutableArray alloc] init];
            //NSLog(@"letter compare: %@", [NSString stringWithFormat:@"%c",a]);
            for(int i=0;i<[contactList count]; i++){ //for each letter go through list of people
                Contact* person = contactList[i];
                NSString *initial = [person.last substringToIndex:1];//get initial of last name
               // NSLog(@"initial: %@", initial);
                if([initial isEqualToString:[NSString stringWithFormat:@"%c",a]]){ //add people whos initial matches alphabet
                    NSLog(@"Added");
                    [tempArray addObject:person]; //array contains people of only one letter
                }
            }
            //NSLog(@"%c : %@", a, tempArray);
            //[contactDict setObject:tempArray forKey:a];
            [contactDict setValue:tempArray forKey:[NSString stringWithFormat:@"%c", a]];
        }
        //NSLog(@"contactDict: %@", contactDict);
        
        contactTitles = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
         
        
        
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


-(Contact *)contactAtIndexName:(NSString*)first usingLast:(NSString *)last usingEmail:(NSString *)email {   //return contact based on name
    for(int i=0; i<[contactList count]; i++){
        Contact *testPerson = contactList[i];
        if((testPerson.first == first)&& (testPerson.last == last) &&(testPerson.email == email)){
            NSLog(@"Returning: %@ %@", testPerson.first, testPerson.last);
            return testPerson;
        }
    }
    NSLog(@"Person not found");
    return nil;
    //return [contactList objectAtIndex:name];
}


-(void)addNewContact:(Contact *)newContact{
//save to plist
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *plistFilePath = [documentsDirectory stringByAppendingPathComponent:@"Contacts.plist"];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Contacts" ofType:@"plist"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSMutableArray *firstNameArray= [[NSMutableArray alloc]init];
    NSMutableArray *lastNameArray= [[NSMutableArray alloc]init];
    NSMutableArray *emailArray= [[NSMutableArray alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:plistFilePath];
    
    if (![fileManager fileExistsAtPath: plistFilePath])
    {
        NSLog(@"File does not exist. Reverting to old path and old plist will be loaded");
        dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
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
    for(int i=0; i<[contactList count]; i++){
        Contact* initialName = contactList[i];
        NSLog(@"Contact list people: %@ %@", initialName.first, initialName.last);
    }
    
//end save to plist
    
//add NEWCONTACT INDEX
    
}

-(void)deleteContact:(NSIndexPath *)indexPath{
    //[contactList removeObjectAtIndex:indexPath.row];
}



@end
