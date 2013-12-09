//
//  userRSVP.m
//  newRSVP
//
//  Created by Daniel Drucker on 7/30/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "userRSVP.h"

@implementation userRSVP

@synthesize first_name;
@synthesize last_name;
@synthesize attending;

- (id)initWithFirstName: (NSString *) firstname andLastName: (NSString *) lastname andAttending: (NSString *) attend
{
    self = [super init];
    if (self) {
        first_name = firstname;
        last_name = lastname;
        attending = attend;
    }
    return self;
}

@end
