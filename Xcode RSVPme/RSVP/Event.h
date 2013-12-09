//
//  Event.h
//  RSVP
//
//  Created by Daniel Drucker on 7/3/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Event : NSObject

@property (nonatomic, assign) NSInteger *event_id;
@property (nonatomic, strong) NSString *event_name;
@property (nonatomic, strong) NSString *event_image_name;
@property (nonatomic, strong) NSString *event_place;
@property (nonatomic, strong) NSString *date_time;
@property (nonatomic, strong) NSString *event_detail;

- (id)initWithName: (NSString *) name andPlace: (NSString *) place andDate: (NSString *) date andDetail: (NSString *) detail andId: (NSInteger *) Id;

@end
