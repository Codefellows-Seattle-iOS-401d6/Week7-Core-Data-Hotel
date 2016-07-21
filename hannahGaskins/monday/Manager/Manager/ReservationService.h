//
//  ReservationService.h
//  Manager
//
//  Created by hannah gaskins on 7/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotel.h"
#import "Guest.h"
#import "Room.h"
#import "Reservation.h"
#import "NSObject+NSManagedObject.h"

typedef void(^ReservationServiceCompletion)();

@interface ReservationService : NSObject

// 3 methods//

+ (NSArray *)avilableRoomMethod:(NSDate *)endDate startDate:(NSDate *)startDate;
+ (void)bookRoomMethod:(NSDate *)endDate startDate:(NSDate *)startDate email:(Room *)room nameField:(UITextField *)nameField lastNameField:(UITextField *)lastNameField emailField:(UITextField *)emailField completion:(ReservationServiceCompletion)completion;

@end
