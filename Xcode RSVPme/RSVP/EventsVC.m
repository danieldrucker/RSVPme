//
//  EventsVC.m
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "EventsVC.h"
#import "newRSVPAppDelegate.h"
#import "ECSlidingViewController.h"
#import "GroupsViewController.h"
#import "EventViewController.h"
#import "Event.h"
#import "AFJSONRequestOperation.h"

@interface EventsVC ()

@end

@implementation EventsVC

@synthesize navBar;
@synthesize toolBar;
@synthesize table;
@synthesize events;
@synthesize json;
@synthesize group_id;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.table.delegate = self;
    self.table.dataSource = self;
    UIImage *greenOne = [UIImage imageNamed:@"GreenNav.png"];
    [self.navBar setBackgroundImage:greenOne forBarMetrics:UIBarMetricsDefault];
    [self.toolBar setBackgroundImage:greenOne forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[GroupsViewController class]])
    {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GroupsViewController"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    events = [NSMutableArray new];
    NSLog(@"group id: %@", self.group_id);
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
    return [self.events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    tableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[tableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    UIImage *cellImage = [UIImage imageNamed:@"EventCell.png"];
    cell.backgroundColor = [UIColor colorWithPatternImage:cellImage];
        
    Event *event = [self.events objectAtIndex:[indexPath row]];
    
    
    cell.title.text = event.event_name;
    cell.detail.text = event.date_time;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    //UIImage *img;
    //img =[UIImage imageNamed: [NSString stringWithFormat:@"%@%@", group.group_image_name, @".png"]];
    //cell.image.image = img;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Event *eventToPass = [self.events objectAtIndex:[indexPath row]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    EventViewController *eventController = [storyboard instantiateViewControllerWithIdentifier:@"EventViewController"];
    eventController.event = eventToPass;
    [self presentViewController:eventController animated:YES completion:nil];

        
}



- (void)retrieveData
{
    // 1
    NSString *format = [NSString stringWithFormat:@"http://localhost/~ddrucker/get_events.php?group_id=%i", 2];
    NSURL *url = [NSURL URLWithString:format];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        for(id entry in JSON)
        {
            Event *myEvent = [Event new];
            myEvent.event_id = [[entry valueForKeyPath:@"event_id"]integerValue];
            myEvent.event_name = [entry valueForKeyPath:@"event_name"];
            myEvent.date_time = [entry valueForKeyPath:@"event_time"];
            myEvent.event_place = [entry valueForKeyPath:@"event_place"];
            myEvent.event_detail = [entry valueForKeyPath:@"event_detail"];
            [events addObject:myEvent];
        }
        [self.table reloadData];
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
