//
//  CreateAccountViewController.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/31/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateAccountViewController : UIViewController <UITextFieldDelegate>


@property (strong, nonatomic) IBOutlet UITextField *email;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UIButton *createButton;
@property (assign, nonatomic) BOOL success;


- (IBAction)createSelected:(id)sender;


@property (strong, nonatomic) NSMutableArray *ready;

@end
