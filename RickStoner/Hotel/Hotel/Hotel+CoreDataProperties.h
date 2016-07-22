//
//  Hotel+CoreDataProperties.h
//  Hotel
//
//  Created by Rick  on 7/21/16.
//  Copyright © 2016 Rick . All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hotel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hotel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *location;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *stars;
@property (nullable, nonatomic, retain) NSSet<Room *> *room;

@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomObject:(Room *)value;
- (void)removeRoomObject:(Room *)value;
- (void)addRoom:(NSSet<Room *> *)values;
- (void)removeRoom:(NSSet<Room *> *)values;

@end

NS_ASSUME_NONNULL_END
