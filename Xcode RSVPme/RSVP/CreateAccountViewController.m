//
//  CreateAccountViewController.m
//  newRSVP
//
//  Created by Daniel Drucker on 7/31/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "CreateAccountViewController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"
#import "newRSVPAppDelegate.h"
#import "LoginViewController.h"

@interface CreateAccountViewController ()

@end

@implementation CreateAccountViewController
@synthesize email;
@synthesize password;
@synthesize firstName;
@synthesize lastName;
@synthesize ready;
@synthesize username;
@synthesize createButton;
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
    email.delegate = self;
    password.delegate = self;
    firstName.delegate = self;
    lastName.delegate = self;
    self.ready = [NSMutableArray arrayWithObjects:@"0", @"0", @"0", @"0", @"0", nil];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == email)
    {
        
        if(![self NSStringIsValidEmail:[email text]])
        {
            // user entered invalid email address
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter a valid email address." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [self.ready replaceObjectAtIndex:3 withObject:@"0"];
        } else [self.ready replaceObjectAtIndex:0 withObject:@"1"];
    }
    else if (textField == password)
    {
        if (password.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Enter an password less than 40 characters." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [self.ready replaceObjectAtIndex:3 withObject:@"0"];
        } else [self.ready replaceObjectAtIndex:1 withObject:@"1"];
    }
    else if (textField == firstName)
    {
        if (firstName.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"First name must be less than 40 characters." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [self.ready replaceObjectAtIndex:3 withObject:@"0"];
        } else [self.ready replaceObjectAtIndex:2 withObject:@"1"];
    }
    else if (textField == lastName)
    {
        NSLog(@"%lu", (unsigned long)lastName.text.length);
        if (lastName.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Last name must be less than 40 characters." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [self.ready replaceObjectAtIndex:3 withObject:@"0"];
        } else [self.ready replaceObjectAtIndex:3 withObject:@"1"];
    }
    else if (textField == username)
    {
        NSLog(@"%lu", (unsigned long)lastName.text.length);
        if (lastName.text.length > 40) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Username must be less than 40 characters." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [self.ready replaceObjectAtIndex:4 withObject:@"0"];
        } else [self.ready replaceObjectAtIndex:4 withObject:@"1"];
    }
}

-(void)insertData
{
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost/~ddrucker/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"http://localhost/~ddrucker/create_account.php"
                                                      parameters:@{@"username":username.text, @"email":email.text, @"password":password.text, @"first_name":firstName.text, @"last_name":lastName.text}];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Print the response body in text
        NSLog(@"Response: %@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        self.success = YES;
        [[NSNotificationCenter defaultCenter]
            postNotificationName:@"creationFinished"
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
}

-(BOOL)isReadytoSubmit
{
    for (int i = 0; i < 4; i++) {
        NSLog(@"%@", [self.ready objectAtIndex:i]);
        if (![[self.ready objectAtIndex:i]  isEqual: @"1"]) {
            return NO;
        }
    }
    return YES;
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

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)creationFinished: (NSNotification *)notify
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (![self isReadytoSubmit]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Not all fields are valid or filled out correctly!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    } else if (self.success)
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
        LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"loginViewController"];
        [self presentViewController:loginViewController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Account was not created." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

- (IBAction)createSelected:(id)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[NSNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(creationFinished:)
        name:@"creationFinished"
        object:nil];
    [self insertData];
}

@end
