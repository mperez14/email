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


@interface ContactDetailTableViewController : UITableViewController <UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic,weak) Contact* contact;

@property (weak, nonatomic) IBOutlet UILabel *lblFirstName;
@property (weak, nonatomic) IBOutlet UILabel *lblLastName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtTime;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *pickerDateTime;

- (IBAction)sendEmail:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
