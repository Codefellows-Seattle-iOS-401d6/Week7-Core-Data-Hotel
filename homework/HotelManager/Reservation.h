//
//  Reservation.h
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Room.h"

@class Guest, Room;

NS_ASSUME_NONNULL_BEGIN

@interface Reservation : NSManagedObject

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room;

@end

NS_ASSUME_NONNULL_END

#import "Reservation+CoreDataProperties.h"
