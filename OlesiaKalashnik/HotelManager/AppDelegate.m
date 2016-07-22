//
//  AppDelegate.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/18/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CoreDataStack.h"
#import "Flurry.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *navC;
@property (strong, nonatomic) ViewController *viewC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootVC];
    [self registerForiCloudNotifications];
    [CoreDataStack.shared bootstrapApp];
    [Flurry startSession:@"76DHYM7BCQSFCX37KRTM"];
    [Flurry logEvent:@"Application was launched"];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [CoreDataStack.shared saveContext];
}

-(void) setupRootVC {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.viewC = [[ViewController alloc] init];
    self.navC = [[UINavigationController alloc ]initWithRootViewController: self.viewC];
    self.window.rootViewController = self.navC;
    
    [self.window makeKeyAndVisible];
}


#pragma mark - Notification Observers
- (void)registerForiCloudNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(storesWillChange:)
                               name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                             object:[[CoreDataStack shared]persistentStoreCoordinator]];
    
    [notificationCenter addObserver:self
                           selector:@selector(storesDidChange:)
                               name:NSPersistentStoreCoordinatorStoresDidChangeNotification
                             object:[[CoreDataStack shared]persistentStoreCoordinator]];
    
    [notificationCenter addObserver:self
                           selector:@selector(persistentStoreDidImportUbiquitousContentChanges:)
                               name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                             object:[[CoreDataStack shared]persistentStoreCoordinator]];
}

# pragma mark - iCloud Support
- (void) persistentStoreDidImportUbiquitousContentChanges:(NSNotification *)changeNotification {
    NSManagedObjectContext *context = [[CoreDataStack shared]managedObjectContext];
    
    [context performBlock:^{
        [context mergeChangesFromContextDidSaveNotification:changeNotification];
    }];
}

- (void)storesWillChange:(NSNotification *)notification {
    NSManagedObjectContext *context = [[CoreDataStack shared]managedObjectContext];
    
    [context performBlockAndWait:^{
        NSError *error;
        
        if ([context hasChanges]) {
            BOOL success = [context save:&error];
            
            if (!success && error) {
                // perform error handling
                NSLog(@"%@",[error localizedDescription]);
            }
        }
        
        [context reset];
    }];
    
    // Refresh your User Interface.
}

- (void)storesDidChange:(NSNotification *)notification {
    // Refresh your User Interface.
}

@end
