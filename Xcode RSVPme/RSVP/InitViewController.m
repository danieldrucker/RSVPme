//
//  InitViewController.m
//  RSVPme
//
//  Created by Daniel Drucker on 6/27/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "InitViewController.h"
#import "newRSVPAppDelegate.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"
#import "WelcomeViewController.h"

@interface InitViewController ()

@end

@implementation InitViewController


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
    
    self.topViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"EventsVC"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
