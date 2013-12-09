//
//  GroupsViewController.m
//  newRSVP
//
//  Created by Daniel Drucker on 7/11/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import "GroupsViewController.h"
#import "newRSVPAppDelegate.h"
#import "ECSlidingViewController.h"
#import "tableCell.h"
#import "Group.h"
#import "AFJSONRequestOperation.h"
#import "EventsVC.h"
#import "InitViewController.h"

@interface GroupsViewController ()

@end

@implementation GroupsViewController
@synthesize groups;
@synthesize json;

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
    self.groupTable.delegate = self;
    self.groupTable.dataSource = self;
    
    [self.slidingViewController setAnchorRightRevealAmount:260.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    groups = [NSMutableArray new];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Groups";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = @"Cell";
    tableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[tableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    //UIImage *cellImage = [UIImage imageNamed:@"GroupCell.png"];
    //cell.backgroundColor = [UIColor colorWithPatternImage:cellImage];
    
    Group *group = [self.groups objectAtIndex:[indexPath row]];
    cell.title.text = group.group_name;
    //cell.detail.text = group.latest_event;
    
    UIImage *img;
    //img =[UIImage imageNamed: [NSString stringWithFormat:@"%@%@", group.group_image_name, @".png"]];
    cell.image.image = img;
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    Group *groupToPass = [self.groups objectAtIndex:[indexPath row]];
    //[self.slidingViewController resetTopView];
    

    
    
    /*
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    EventsVC *eventsVC = [storyboard instantiateViewControllerWithIdentifier:@"EventsVC"];
    eventsVC.group_id = groupToPass.group_id;
    //NSLog(@"group id: %@", eventsVC.group_id);
    [self presentViewController:eventsVC animated:YES completion:nil];
    */

}

- (void)retrieveData
{
    // 1
    newRSVPAppDelegate *delegate = (newRSVPAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *format = [NSString stringWithFormat:@"http://localhost/~ddrucker/get_groups.php?token=%@", delegate.token];
    NSURL *url = [NSURL URLWithString:format];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     // 3
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            for(id entry in JSON)
            {
                Group *myGroup = [Group new];
                myGroup.user_id = [[entry valueForKeyPath:@"user_id"]integerValue];
                myGroup.group_id = [[entry valueForKeyPath:@"group_id"]integerValue];
                myGroup.created_by = [[entry valueForKeyPath:@"created_by"]integerValue];
                myGroup.group_name = [entry valueForKeyPath:@"group_name"];
                myGroup.date_created = [entry valueForKeyPath:@"date_created"];
                myGroup.public_or_private = [entry valueForKeyPath:@"public_or_private"];
                [groups addObject:myGroup];
            }
            [self.groupTable reloadData];
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
