//
//  tableCell.m
//  RSVP
//
//  Created by Daniel Drucker on 7/8/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "tableCell.h"

@implementation tableCell
@synthesize title;
@synthesize detail;
@synthesize image;




- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }

    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithRed:0.2 green:1 blue:0 alpha:0.5];
    self.selectedBackgroundView = view;
    image.layer.shadowOffset = CGSizeMake(-1, 0);
    image.layer.shadowOpacity = 1;
    //image.layer.borderColor = [UIColor blackColor].CGColor;
    //image.layer.borderWidth = 2.0f;
    


    // Configure the view for the selected state
}

@end
