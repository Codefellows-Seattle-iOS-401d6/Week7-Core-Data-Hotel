//
//  AppDelegate+CoreDataStack.h
//  ObjectManager
//
//  Created by Derek Graham on 7/21/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (CoreDataStack)
+ (NSURL *)applicationDocumentsDirectory;
+ (void)saveContext;

+ (NSManagedObjectContext *)managedObjectContext;
+ (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
+ (NSManagedObjectModel *)managedObjectModel;

+ (void) loadDataFromJSON;

@end
