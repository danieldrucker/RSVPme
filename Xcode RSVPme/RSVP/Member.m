//
//  Member.m
//  RSVP
//
//  Created by Daniel Drucker on 7/3/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "Member.h"

@implementation Member

@synthesize first_name;
@synthesize last_name;
@synthesize email;
@synthesize member_photo;

- (id)init {
    self = [super init];
    if (self) {
        self.first_name = @"";
        self.last_name = @"";
        self.email = @"";
        self.member_photo = [[UIImage alloc]init];
    }
    return self;
}

@end
