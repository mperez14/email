//
//  ContactDetailTableViewController.h
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
#import <MessageUI/MessageUI.h>
#import <FontAwesomeKit/FontAwesomeKit.h>

#import <FontAwesomeIconFactory/FontAwesomeIconFactory.h>



@interface ContactDetailTableViewController : UITableViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic,weak) Contact* contact;

@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDateTime;


@end
