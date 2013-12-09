//
//  GroupsViewController.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *groups;
@property (strong, nonatomic) IBOutlet UITableView *groupTable;
@property (strong, nonatomic) NSMutableArray *json;




@end
