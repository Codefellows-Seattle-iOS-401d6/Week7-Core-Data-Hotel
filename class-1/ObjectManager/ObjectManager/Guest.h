//
//  Guest.h
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

+(instancetype)guestWithNameAndEmail:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email  payment:(NSString *)payment notes:(NSString *)notes;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"
