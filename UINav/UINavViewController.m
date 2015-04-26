//
//  UINavViewController.m
//  UINav
//
//  Created by Daniel Muckerman on 5/5/14.
//  Copyright (c) 2014 Finalesoft. All rights reserved.
//

#import "UINavViewController.h"

@interface UINavViewController () <UINavigationControllerDelegate>

@end

@implementation UINavViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *barColour = [UIColor colorWithRed:0.027 green:0.212 blue:0.259 alpha:1.000];
    self.navigationBar.barTintColor = barColour;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
