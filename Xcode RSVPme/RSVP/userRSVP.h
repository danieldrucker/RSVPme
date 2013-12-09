//
//  userRSVP.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/30/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface userRSVP : NSObject

@property (nonatomic, strong) NSString *first_name;
@property (nonatomic, strong) NSString *last_name;
@property (nonatomic, strong) NSString *attending;

- (id)initWithFirstName: (NSString *) firstname andLastName: (NSString *) lastname andAttending: (NSString *) attend;

@end
