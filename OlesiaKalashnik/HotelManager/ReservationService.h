//
//  ReservationService.h
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reservation.h"
#import "Room.h"


@interface ReservationService : NSObject

-(NSArray *)getAvailableRooms:(NSDate *)startDate endDate:(NSDate *)endDate;
-(Reservation *)saveReservation:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room name:(NSString *)name lastName:(NSString *)lastName email:(NSString *)email;
-(NSArray *)searchForReservations:(NSString *)searchText;

@end
