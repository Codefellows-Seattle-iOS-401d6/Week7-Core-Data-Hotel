//
//  NSManagedObjectContext+CoreDataStack.m
//  ObjectManager
//
//  Created by Derek Graham on 7/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "NSManagedObjectContext+CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"
#import <objc/runtime.h>


@implementation NSManagedObjectContext (CoreDataStack)
- (void) loadDataFromJSON {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    NSError *error;
    
    NSInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    if (count == 0 ){
        NSDictionary *hotels = [NSDictionary new];
        NSDictionary *rooms = [NSDictionary new];
        
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
        
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        NSLog(@"%@", rootObject);
        
        if (jsonError) { NSLog(@"Error serializing data, Error: %@", jsonError);
        } else
        {
            hotels = rootObject[@"Hotels"];
            
            for (NSDictionary *hotel in hotels) {
                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
                
                newHotel.name = hotel [@"name"];
                newHotel.location =  hotel [@"location"];
                newHotel.rating =  hotel [@"stars"];
                
                
                rooms = hotel[@"rooms"];
                
                NSMutableSet *roomsSet = [[NSMutableSet alloc]init];
                
                for (NSDictionary *room in rooms){
                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
                    
                    newRoom.roomNumber = room [@"number"];
                    newRoom.beds = room[@"beds"];
                    newRoom.rate = room [@"rate"];
                    
                    newRoom.hotel = newHotel;
                    
                    NSLog(@"%@", newRoom);
                    [roomsSet addObject:newRoom];
                }
                newHotel.rooms = roomsSet;
                
            }
            
            NSError *saveError;
            BOOL isSaved = [self.managedObjectContext save: &saveError];
            
            if(isSaved) {
                NSLog(@"success saving");
                
            } else {
                NSLog(@"error saving");
                
            }
        }
    }
    else {
        NSLog(@"database contains data, yay");
    }
}

#pragma mark - Core Data stack

//@synthesize managedObjectContext = _managedObjectContext;
//@synthesize managedObjectModel = _managedObjectModel;
//@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


//- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
//{
//    objc_setAssociatedObject(self, @selector(managedObjectContext), managedObjectContext, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSManagedObjectContext*)managedObjectContext
//{
//    return objc_getAssociatedObject(self, @selector(managedObjectContext));
//}
//- (void)setTag:(NSSting *)tag
//{
//    objc_setAssociatedObject(self, @selector(tag), tag, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (NSString *)tag
//{
//    return objc_getAssociatedObject(self, @selector(tag));
//}

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.derekgraham.ObjectManager" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)setManagedObjectModel:(NSManagedObjectModel *)managedObjectModel
{
    objc_setAssociatedObject(self, @selector(managedObjectModel), managedObjectModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (objc_getAssociatedObject(self, @selector(managedObjectModel)) != nil) {
        return objc_getAssociatedObject(self, @selector(managedObjectModel));
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ObjectManager" withExtension:@"momd"];
    [self setManagedObjectModel: [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL]];
    return objc_getAssociatedObject(self, @selector(managedObjectModel));
}

- (void)setPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    objc_setAssociatedObject(self, @selector(persistentStoreCoordinator), persistentStoreCoordinator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    
    if (objc_getAssociatedObject(self, @selector(persistentStoreCoordinator)) != nil)
    {
        
        return objc_getAssociatedObject(self, @selector(persistentStoreCoordinator));
    }
//    if (_persistentStoreCoordinator != nil) {
//        return _persistentStoreCoordinator;
//    }
    
    // Create the coordinator and store
    
//    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    [self setPersistentStoreCoordinator: [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]]];

    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"ObjectManager.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
//    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    if (![objc_getAssociatedObject(self, @selector(persistentStoreCoordinator)) addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
    
        
        //    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return objc_getAssociatedObject(self, @selector(persistentStoreCoordinator));
}


- (void)setManagedObjectContext:(NSManagedObjectContext *)managedObjectContext
{
    objc_setAssociatedObject(self, @selector(managedObjectContext), managedObjectContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (objc_getAssociatedObject(self, @selector(managedObjectContext)) != nil)
    {
        
        return objc_getAssociatedObject(self, @selector(managedObjectContext));
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    [self setManagedObjectContext: [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType]];
    [objc_getAssociatedObject(self, @selector(managedObjectContext)) setPersistentStoreCoordinator:coordinator];
     return objc_getAssociatedObject(self, @selector(managedObjectContext));

}

//- (NSManagedObjectContext *)managedObjectContext {
//    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
//    if (_managedObjectContext != nil) {
//        return _managedObjectContext;
//    }
//    
//    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
//    if (!coordinator) {
//        return nil;
//    }
//    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
//    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
//    return _managedObjectContext;
//}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
