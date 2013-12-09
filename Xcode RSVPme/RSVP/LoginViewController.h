//
//  LoginViewController.h
//  newRSVP
//
//  Created by Daniel Drucker on 8/5/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *loginEmail;
@property (strong, nonatomic) IBOutlet UITextField *loginPassword;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (assign, nonatomic) BOOL success;


- (IBAction)login:(id)sender;

@end
