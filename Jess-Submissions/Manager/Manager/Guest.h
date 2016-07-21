//
//  Guest.h
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+ (instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
