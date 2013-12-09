//
//  EventsVC.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "tableCell.h"


@interface EventsVC : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UINavigationBar *navBar;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSMutableArray *json;
@property (strong, nonatomic) NSMutableArray *events;
@property (nonatomic, assign) NSInteger *group_id;

- (void)retrieveData;

@end
