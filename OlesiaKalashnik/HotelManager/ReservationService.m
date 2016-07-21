//
//  ReservationService.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "NSManagedObject+ManagedContext.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface ReservationService ()

@property (strong, nonatomic) NSArray *availableRooms;
@end


@implementation ReservationService

-(NSArray *)getAvailableRooms:(NSDate *)startDate endDate:(NSDate *)endDate {
    if (!_availableRooms) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate ];
        
        NSError *error;
        NSArray *results = [[NSManagedObject managedContext] executeFetchRequest: request error:&error];
        if (error) {
            NSLog(@"Error with fetching reserved rooms");
        } else {
            NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
            for (Reservation *reservation in results) {
                //NSLog(@"%@", reservation.room.number);
                //if (reservation != nil) {
                [unavailableRooms addObject: reservation.room];
                //}
            }
            NSError *availableFetcherror;
            
            NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
            checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
            _availableRooms = [[NSManagedObject managedContext] executeFetchRequest: checkRequest error:&availableFetcherror];
            if (availableFetcherror) {
                NSLog(@"Error with fetching available rooms");
            }
        }
    }
    return _availableRooms;
    
}

-(Reservation *)saveReservation:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room name:(NSString *)name lastName:(NSString *)lastName email:(NSString *)email {
    Reservation *reservation = [Reservation reservationWithStartDate: startDate endDate:endDate room: room];
    reservation.guest = [Guest guestWithName:name lastName:lastName email:email];
    
    NSError *error;
    [[NSManagedObject managedContext] save:&error];
    
    if (error) {
        NSLog(@"Error saving reservation.");
    }
    return reservation;
}

-(NSArray *)searchForReservations:(NSString *)searchText {
    NSString *text = searchText;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.lastName == %@", text];
    NSError *error;
    NSArray *results = [[NSManagedObject managedContext] executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"Error searching for reservations");
    } else {
        NSLog(@"Succussful search for reservations");
    }
    return results;
}

@end
