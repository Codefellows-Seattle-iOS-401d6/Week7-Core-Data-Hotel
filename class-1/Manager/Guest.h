//
//  Guest.h
//  Manager
//
//  Created by Sean Champagne on 7/18/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(instancetype)guestWithName:(NSString *)name;;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
