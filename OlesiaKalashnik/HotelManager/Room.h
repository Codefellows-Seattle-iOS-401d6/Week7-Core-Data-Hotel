//
//  Room.h
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Hotel, Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Room : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "Room+CoreDataProperties.h"