//
//  AppDelegate.m
//  Manager
//
//  Created by hannah gaskins on 7/18/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "Reservation.h"
#import "Guest.h"
#import "Flurry.h"

@interface AppDelegate ()

@property (strong, nonatomic) UINavigationController *navigationController;
@property (strong, nonatomic) ViewController *viewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupRootViewController];
    [self bootstrapApp];
    
    [Flurry startSession:@"F6CXYJSMQGXG59RQP5X8"]; // Flurry Application key
    
    // testing
    [Flurry logEvent:@"Launched App"];
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [self saveContext];
}

- (void)setupRootViewController
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.viewController = [[ViewController alloc]init];
    self.navigationController = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    
    self.window.rootViewController = self.navigationController;
    
    [self.window makeKeyAndVisible];
}

- (void)bootstrapApp
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    NSError *error;
    
    NSInteger count = [self.managedObjectContext countForFetchRequest:request
                                                                error:&error];
    
    if (count == 0) {
        
        NSDictionary *hotels = [NSDictionary new];
        NSDictionary *rooms = [NSDictionary new];
        
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                   options:0
                                                                     error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error serializing data. Error: %@", jsonError);
        }
        
        else {
            
            hotels = rootObject[@"Hotels"];
            
            for (NSDictionary *hotel in hotels) {
                
                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel"
                                                                inManagedObjectContext:self.managedObjectContext];
                newHotel.name = hotel[@"name"];
                newHotel.location = hotel[@"location"];
                newHotel.stars = hotel[@"stars"];
                
                rooms = hotel[@"rooms"];
                
                NSMutableSet *hotelRooms = [[NSMutableSet alloc]init];
                
                for (NSDictionary *room in rooms) {
                    
                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room"
                                                                  inManagedObjectContext:self.managedObjectContext];
                    
                    newRoom.number = room[@"number"];
                    newRoom.beds = room[@"beds"];
                    newRoom.rate = room[@"rate"];
                    newRoom.hotel = newHotel;
                    
                    // Collect all rooms...
                    
                    [hotelRooms addObject:newRoom];
                }
                
                newHotel.rooms = hotelRooms;
            }
            
            NSError *saveError;
            BOOL isSaved = [self.managedObjectContext save:&saveError];
            
            if (isSaved) {
                NSLog(@"Success saving...");
            }
            
            else {
                NSLog(@"%@", saveError.description);
                NSLog(@"Error saving...");
            }
            
        }
    }
    
    else {
        NSLog(@"Database contains data...");
    }
}



#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Manager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"Manager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption: [NSNumber numberWithBool:YES]};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}



- (NSManagedObjectContext *)managedObjectContext {
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
