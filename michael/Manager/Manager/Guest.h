//
//  Guest.h
//  Manager
//
//  Created by Michael Sweeney on 7/18/16.
//  Copyright © 2016 Michael Sweeney. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+(instancetype)guestWithName: (NSString *)name;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
