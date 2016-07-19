//
//  Reservation.h
//  Manager
//
//  Created by Sean Champagne on 7/18/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "Room.h"

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

- (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room;

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
