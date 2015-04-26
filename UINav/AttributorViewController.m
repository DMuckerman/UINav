//
//  AttributorViewController.m
//  UINav
//
//  Created by Daniel Muckerman on 5/5/14.
//  Copyright (c) 2014 Finalesoft. All rights reserved.
//

#import "AttributorViewController.h"
#import "UINavFilesTableViewController.h"
#import <Cloud/Cloud.h>

@interface AttributorViewController () <CLAPIEngineDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *passWord;
@property (nonatomic) int userNameTyped;
@property (nonatomic) int passWordTyped;

@end

@implementation AttributorViewController

/**
 *  View loads, and initializes some things
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userName.keyboardAppearance = UIKeyboardAppearanceDark;
    self.passWord.keyboardAppearance = UIKeyboardAppearanceDark;
    self.passWord.secureTextEntry = YES;
    [self.userName becomeFirstResponder];
}

/**
 *  View loads, and initializes some things
 */
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.userName becomeFirstResponder];
}

/**
 *  If the connection fails for some reason, here's the debug output
 *
 *  @param error                Error condition
 *  @param connectionIdentifier Connection identifier. Kinda useless without proper docs, tho
 *  @param userInfo             User info. Again, kinda useless without proper docs
 */
- (void)requestDidFailWithError:(NSError *)error connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo {
	NSLog(@"[FAIL]: %@, %@", connectionIdentifier, error);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"login"])
    {
        // Get reference to the destination view controller
        UINavFilesTableViewController *vc = [segue destinationViewController];
        
        // Pass any objects to the view controller here, like...
        vc.userName = self.userName.text;
        vc.passWord = self.passWord.text;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if([identifier isEqualToString:@"login"]){
        
        if (![self.userName.text isEqualToString: @""] && ![self.passWord.text isEqualToString: @""]) {
            // If the login seems valid, it will try to proceed
            // I've double and triple checked the code, but without any solid documentation of the Objective-C library
            // for the API, I can't figure out how to do user authentication. So I guess that's a 2.0 feature
            
            return YES;
        } else {
            //Invalid login
            UIAlertView *messageAlert = [[UIAlertView alloc]
                                         initWithTitle:@"Invalid login!" message:@"Username or password is blank! Please enter one and try again." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            // Display Alert Message
            [messageAlert show];
            return NO;
        }
        
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
