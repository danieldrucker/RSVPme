//
//  tableCell.h
//  RSVP
//
//  Created by Daniel Drucker on 7/8/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tableCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *detail;

@end

