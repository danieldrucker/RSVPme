//
//  Event.m
//  RSVP
//
//  Created by Daniel Drucker on 7/3/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "Event.h"

@implementation Event

@synthesize event_name;
@synthesize event_image_name;
@synthesize event_place;
@synthesize date_time;
@synthesize event_detail;
@synthesize event_id;


- (id)initWithName: (NSString *) name andPlace: (NSString *) place andDate: (NSString *) date andDetail: (NSString *) detail andId: (NSInteger *) Id
{
    self = [super init];
    if (self) {
        event_id = Id;
        event_name = name;
        event_image_name = @"duck.png";
        event_place = place;
        date_time = date;
        event_detail = detail;
    }
    return self;
}

@end
