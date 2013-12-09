//
//  LoadingVC.m
//  newRSVP
//
//  Created by Daniel Drucker on 8/6/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "LoadingVC.h"
#import "InitViewController.h"
#import "newRSVPAppDelegate.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"
#import "WelcomeViewController.h"

@interface LoadingVC ()

@end

@implementation LoadingVC


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
    newRSVPAppDelegate *delegate = (newRSVPAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"Delegate Token: %@", delegate.token);
    if (delegate.token != nil) {
        [self tokenCheck:delegate.token];
    } else {
        [self changeToWelcome];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tokenCheck: (NSString *)usertoken
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/~ddrucker/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://localhost/~ddrucker/valid_token.php"
                                                      parameters:@{@"token":usertoken}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *response =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Response Token: %@", response);
        if ([response isEqualToString:@"True"]) {
            [self changeToInit];
        } else {
            [self changeToWelcome];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSLog(@"Error: %@", error);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                     message:[NSString stringWithFormat:@"%@",error]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    [operation start];
}

-(void)changeToWelcome
{
    WelcomeViewController *welcomeController = [self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeController"];
    [self presentViewController:welcomeController animated:YES completion:nil];
    
}

-(void)changeToInit
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    InitViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"initViewController"];
    [self presentViewController:initViewController animated:YES completion:nil];
}

@end
