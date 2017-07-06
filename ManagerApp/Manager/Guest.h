//
//  Guest.h
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+(instancetype)guestWithEmail:(NSString *)email first:(NSString *)first last:(NSString *)last;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
