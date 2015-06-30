//
//  ContactDetailTableViewController.m
//  email
//
//  Created by Matthew Perez on 5/30/15.
//  Copyright (c) 2015 Matthew Perez. All rights reserved.
//

#import "ContactDetailTableViewController.h"

@interface ContactDetailTableViewController ()

@end

@implementation ContactDetailTableViewController
@synthesize contact;
@synthesize lblEmail, lblFirstName, lblLastName, pickerDateTime;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [lblFirstName setText:[contact first]];
    [lblLastName setText:[contact last]];
    [lblEmail setText:[contact email]];
    
    
    FAKFontAwesome *sendIcon = [FAKFontAwesome sendIconWithSize:20];
    [sendIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *takePhotoImage = [sendIcon imageWithSize:CGSizeMake(20, 20)];
    //sendIcon.iconFontSize = 15;
    UIBarButtonItem *send3Button = [UIBarButtonItem new];
    send3Button.image = takePhotoImage;
    send3Button.action = @selector(send3Email);
    send3Button.target = self;
    send3Button.enabled = YES;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:send3Button, nil];
    
    //tableView.allowsSelection = NO;
    
}

-(void) send3Email{
    //format date
    NSDate *myDate = pickerDateTime.date;
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"cccc, MMM d hh:mm aa"];
    NSString *prettyVersion = [dateFormat stringFromDate:myDate];
    //pretty version = email version of date and time
    
    //SEND EMAIL
    NSString *emailTitle = @"Appointment Date/Time";
    // Email Content
    NSString *messageBody =[NSString stringWithFormat:@"Aloha %@,\nYour next appointment is scheduled for %@", lblFirstName.text, prettyVersion];
    // To address
    NSString *emailAddress = [NSString stringWithFormat:@"%@", lblEmail.text];
    NSArray *toRecipents = [NSArray arrayWithObject:emailAddress];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    // Present mail view controller on screen
    [self presentViewController:mc animated:YES completion:NULL];
}

//mail code
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


/*
- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}
*/
//dismiss keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textFieldNew{
    NSLog(@"dismiss");
    return [textFieldNew resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath2:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
*/
- (BOOL)tableView:(UITableView *)tableView
shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return FALSE;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
