//
//  ReservationService.m
//  Manager
//
//  Created by Jessica Malesh on 7/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "ReservationService.h"
#import "Guest.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Room.h"
#import "NSObject+NSManagedObjectContext.h"
#import "Reservation+CoreDataProperties.h"
#import "Room+CoreDataProperties.h"
#import "Hotel+CoreDataProperties.h"
#import "Guest+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ReservationService () <NSFetchedResultsControllerDelegate>


@end

@implementation ReservationService

+ (NSArray *)isRoomAvailable:(NSDate *)startDate endDate:(NSDate *)endDate
{


    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];

    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:nil];

    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];

    for (Reservation *reservation in results) {
        [unavailableRooms addObject:reservation.room];
    }

    NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    NSArray *availArray = [delegate.managedObjectContext executeFetchRequest:checkRequest error:nil];


    return availArray;

}

//+ (Reservation *)bookRoom:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room firstName:(UITextField *)firstName lastName:(UITextField *)lastName email:(UITextField *)email
//{
//    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate room:room];
//    
//    room.reservation = reservation;
//    
//
//    reservation.guest = [Guest guestWithName:firstName.text lastName:lastName.text email:email.text];
//    
//    return reservation;
//}



@end
