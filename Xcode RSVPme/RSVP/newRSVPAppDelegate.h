//
//  newRSVPAppDelegate.h
//  newRSVP
//
//  Created by Daniel Drucker on 7/2/13.
//  Copyright (c) 2013 Daniel Drucker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Group.h"
#import "Event.h"

@interface newRSVPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) NSString *token;


- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
