//
//  CoreDataStack.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "CoreDataStack.h"
#import "ViewController.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"
#import "AppDelegate.h"
#import "NSManagedObject+ManagedContext.h"

@implementation CoreDataStack

+(instancetype) shared {
    static CoreDataStack *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[[self class]alloc]init];
    });
    return shared;
}

-(instancetype)init {
    self = [super init];
    return self;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(void)bootstrapApp {
    NSManagedObjectContext *context = [NSManagedObject managedContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Hotel"];
    NSError *error;
    
    NSInteger count = [context countForFetchRequest: request error: &error];
    if (count == 0) {
        NSDictionary *hotels = [[NSDictionary alloc]init];
        NSDictionary *rooms = [[NSDictionary alloc] init];
        
        NSString * jsonPath = [[NSBundle mainBundle] pathForResource:@"hotels" ofType: @"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObj = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        if (jsonError) {
            NSLog(@"Error serializing JSON. Error: %@", jsonError);
        } else {
            hotels = rootObj[@"Hotels"];
            for (NSDictionary *hotel in hotels) {
                
                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:context];
                newHotel.name = hotel[@"name"];
                newHotel.location = hotel[@"location"];
                newHotel.stars = hotel[@"stars"];
                
                rooms = hotel[@"rooms"];
                NSMutableSet *mutableRooms =[[NSMutableSet alloc]init];
                
                for (NSDictionary* room in rooms) {
                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext: context];
                    newRoom.number = room[@"number"];
                    newRoom.beds = room[@"beds"];
                    newRoom.rate = room[@"rate"];
                    newRoom.hotel = newHotel;
                    
                    [mutableRooms addObject: newRoom];
                }
                newHotel.rooms = mutableRooms;
            }
            
            NSError *saveError;
            BOOL isSaved = [context save:&saveError];
            if(isSaved) {
                NSLog(@"Successful saving");
            } else {
                NSLog(@"Unsuccessful saving");
            }
        }
    }  else {
        NSLog(@"Database contains data");
    }
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //CoreDataStack *coreDataStack = [[CoreDataStack alloc]init];
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "ok.HotelManager" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelManager" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];

    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HotelManager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption: [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption: [NSNumber numberWithBool:YES], NSPersistentStoreUbiquitousContentNameKey: @"HotelManagerUbiquitousContainer"};
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) { //for testing: change store type to NSInMemoryStoreType
        
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

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        [managedObjectContext refreshAllObjects];
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
@end
