//
//  ScheduleApptTableViewController.h
//  email
//
//  Created by Matthew Perez on 5/31/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScheduleApptTableViewController : UITableViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtTime;
@property (weak, nonatomic) IBOutlet UITextField *txtDate;

@end
