//
//  CoreDataStack.h
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype) shared;

-(void)bootstrapApp;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

@end
