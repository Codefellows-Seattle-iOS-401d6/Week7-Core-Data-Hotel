//
//  Guest.h
//  Manager
//
//  Created by Erin Roby on 7/18/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+(instancetype)guestInitWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"