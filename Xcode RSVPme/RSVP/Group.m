//
//  Group.m
//  RSVP
//
//  Created by Daniel Drucker on 7/3/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "Group.h"

@implementation Group

@synthesize user_id;
@synthesize group_id;
@synthesize created_by;
@synthesize group_name;
@synthesize date_created;
@synthesize public_or_private;
@synthesize members;
@synthesize events;

- (id)init {
    self = [super init];
    if (self) {
        self.user_id = 0;
        self.group_id = 0;
        self.created_by = 0;
        self.group_name = @"";
        self.date_created = @"";
        self.public_or_private = @"";
        self.members = [[NSMutableArray alloc]init];
        self.events = [[NSMutableArray alloc]init];
    }
    return self;
}

@end
