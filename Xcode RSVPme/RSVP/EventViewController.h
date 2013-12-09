//
//  EventViewController.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface EventViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIImageView *eventBackground;
@property (strong, nonatomic) IBOutlet UINavigationItem *eventNavBar;
@property (strong, nonatomic) IBOutlet UIToolbar *eventToolbar;
@property (strong, nonatomic) IBOutlet UITableView *eventTable;
@property (strong, nonatomic) IBOutlet UILabel *eventPlace;
@property (strong, nonatomic) IBOutlet UILabel *eventTime;
@property (strong, nonatomic) IBOutlet UILabel *eventAttending;
@property (strong, nonatomic) IBOutlet UILabel *eventDetail;
@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) NSMutableArray *members;
@property (strong, nonatomic) Event *event;

- (void)retrieveData;


@end
