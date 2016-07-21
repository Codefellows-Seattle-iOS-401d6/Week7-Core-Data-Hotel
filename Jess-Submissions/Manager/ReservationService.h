//
//  ReservationService.h
//  Manager
//
//  Created by Jessica Malesh on 7/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation.h"
#import "Guest.h"

@interface ReservationService : NSObject

+ (NSArray *)isRoomAvailable:(NSDate *)startDate endDate:(NSDate *)endDate;
//+ (Reservation *)bookRoom:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room firstName:(UITextField *)firstName lastName:(UITextField *)lastName email:(UITextField *)email;

@end

