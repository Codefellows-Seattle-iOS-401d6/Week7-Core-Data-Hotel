//
//  Reservation+CoreDataProperties.h
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Reservation.h"

NS_ASSUME_NONNULL_BEGIN

@interface Reservation (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *end;
@property (nullable, nonatomic, retain) NSDate *start;
@property (nullable, nonatomic, retain) Room *room;
@property (nullable, nonatomic, retain) Guest *guest;

@end

NS_ASSUME_NONNULL_END
