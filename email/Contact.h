//
//  Contact.h
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

//variables
@property (nonatomic, copy) NSString* first;
@property (nonatomic, copy) NSString* last;
@property (nonatomic, copy) NSString* email;


//behaviors, methods
-(id) initWithFirstName:(NSString*) tempFirst
               LastName:(NSString*) tempLast
                  Email:(NSString*) tempEmail;
@end
