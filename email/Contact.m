//
//  Contact.m
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import "Contact.h"

@implementation Contact
@synthesize first, last, email;

-(id)initWithFirstName:(NSString *)tempFirst
              LastName:(NSString *)tempLast
                 Email:(NSString *)tempEmail{
    self = [super init];
    if (self){ //correctly init self
        first = tempFirst;
        last = tempLast;
        email = tempEmail;
        return self;
    }
    else{//no object created in self
        return nil; //no output is created
    }
}


@end
