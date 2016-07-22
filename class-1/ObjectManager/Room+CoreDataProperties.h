//
//  Room+CoreDataProperties.h
//  ObjectManager
//
//  Created by Derek Graham on 7/21/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Room.h"

NS_ASSUME_NONNULL_BEGIN

@interface Room (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *beds;
@property (nullable, nonatomic, retain) NSDecimalNumber *rate;
@property (nullable, nonatomic, retain) NSNumber *roomNumber;
@property (nullable, nonatomic, retain) NSNumber *smoking;
@property (nullable, nonatomic, retain) NSNumber *pets;
@property (nullable, nonatomic, retain) Hotel *hotel;
@property (nullable, nonatomic, retain) Reservation *reservation;

@end

NS_ASSUME_NONNULL_END