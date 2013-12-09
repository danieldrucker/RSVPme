//
//  Group.h
//  RSVP
//
//  Created by Daniel Drucker on 7/3/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Event.h"


@interface Group : NSObject

@property (nonatomic, assign) NSInteger *user_id;
@property (nonatomic, assign) NSInteger *group_id;
@property (nonatomic, assign) NSInteger *created_by;
@property (nonatomic, strong) NSString *group_name;
@property (nonatomic, strong) NSString *date_created;
@property (nonatomic, strong) NSString *public_or_private;
@property (nonatomic, strong) NSMutableArray *members;
@property (nonatomic, strong) NSMutableArray *events;


@end
