//
//  LoginViewController.m
//  newRSVP
//
//  Created by Daniel Drucker on 8/5/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "LoginViewController.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"
#import "InitViewController.h"
#import "newRSVPAppDelegate.h"
#import "MBProgressHUD.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginEmail;
@synthesize loginPassword;
@synthesize goButton;
@synthesize success;

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
    loginEmail.delegate = self;
    loginPassword.delegate = self;
    self.success = NO;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == loginEmail)
    {
        if(![self NSStringIsValidEmail:[loginEmail text]])
        {
            // user entered invalid email address
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid email address." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
    else if (textField == loginPassword)
    {
        if (loginPassword.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter an password less than 40 characters." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)insertData
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/~ddrucker/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://localhost/~ddrucker/login.php"
                                                      parameters:@{@"email":loginEmail.text, @"password":loginPassword.text}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSString *t = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"Login Token Response: %@", t);
        if ([t length] == 14) {
            self.success = YES;
            newRSVPAppDelegate *delegate = (newRSVPAppDelegate *)[[UIApplication sharedApplication] delegate];
            delegate.token = t;
            NSUserDefaults * standardUserDefaults = [NSUserDefaults standardUserDefaults];
            [standardUserDefaults setObject:t forKey:@"token"];
            [standardUserDefaults synchronize];
        }
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"loginFinished"
         object:self];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                     message:[NSString stringWithFormat:@"%@",error]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }];
    [operation start];
    [operation waitUntilFinished];
}

- (void)loginFinished: (NSNotification *)notify
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.success)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        InitViewController *initViewController = [storyboard instantiateViewControllerWithIdentifier:@"initViewController"];
        [self presentViewController:initViewController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed. Please try again." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (IBAction)login:(id)sender
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(loginFinished:)
        name:@"loginFinished"
        object:nil];
    [self insertData];
    //NSLog(@"%hhd", self.success);

}

@end
