//
//  Guest.h
//  Manager
//
//  Created by hannah gaskins on 7/18/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AppDelegate.h"

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

// instance method
+ (instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;


@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
