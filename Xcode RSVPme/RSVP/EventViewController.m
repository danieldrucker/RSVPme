//
//  EventViewController.m
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "EventViewController.h"
#import "userRSVP.h"
#import "tableCell.h"
#import "AFJSONRequestOperation.h"

@interface EventViewController ()

@end

@implementation EventViewController

@synthesize eventBackground;
@synthesize eventNavBar;
@synthesize eventToolbar;
@synthesize eventTable;
@synthesize eventPlace;
@synthesize eventTime;
@synthesize eventAttending;
@synthesize eventDetail;
@synthesize members;
@synthesize json;
@synthesize event;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Customize
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.eventTable.delegate = self;
    self.eventTable.dataSource = self;
    //UIImage *background = [UIImage imageNamed:@"EventBackground.png"];
    //[self.eventBackground setBackgroundColor:[UIColor colorWithPatternImage:background]];

    
    eventNavBar.title = event.event_name;
    //eventPlace.textAlignment = uitextal
    eventTime.text = event.date_time;
    eventPlace.text = event.event_place;
    eventDetail.text = event.event_detail;
    members = [NSMutableArray new];
    [self retrieveData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    tableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[tableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    userRSVP *r = [self.members objectAtIndex:[indexPath row]];
    
    NSMutableString *name = [NSMutableString stringWithString:r.first_name];
    [name appendString:@" "];
    [name appendString:r.last_name];
    cell.title.text = name;
    cell.detail.text = r.attending;
    
    return cell;
}


- (void)retrieveData
{
    // 1
    NSString *format = [NSString stringWithFormat:@"http://localhost/~ddrucker/get_userRSVPs.php?event_id=%i", self.event.event_id];
    NSURL *url = [NSURL URLWithString:format];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for(id entry in JSON)
        {
            userRSVP *myRSVP = [userRSVP new];
            myRSVP.first_name = [entry valueForKeyPath:@"first_name"];
            myRSVP.last_name = [entry valueForKeyPath:@"last_name"];
            myRSVP.attending = [entry valueForKeyPath:@"user_RSVP"];
            [members addObject:myRSVP];
        }
        [self.eventTable reloadData];
    }
     // 4
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error);
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                     message:[NSString stringWithFormat:@"%@",error]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
                                                    }];
    
    // 5
    [operation start];
}




@end
