//
//  ReservationService.m
//  Manager
//
//  Created by hannah gaskins on 7/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "ReservationService.h"
#import "Hotel.h"
#import "DateViewController.h"
#import "AvailabilityViewController.h"
#import "Guest.h"
#import "Room.h"
#import "Reservation.h"
#import "NSObject+NSManagedObject.h"

@interface ReservationService ()


@end

@implementation ReservationService

// method to check room availability

+ (NSArray *)avilableRoomMethod:(NSDate *)endDate startDate:(NSDate *)startDate
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    
    for (Reservation *res in results) {
        NSLog(@"%@", res.guest.firstName);
        NSLog(@"%@", res.startDate);
        NSLog(@"%@", res.endDate);
    }
    
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
    
    for (Reservation *reservation in results) {
        [unavailableRooms addObject:reservation.room];
    }
    
    NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    
    checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];

    NSArray *checkArray = [delegate.managedObjectContext executeFetchRequest:checkRequest error:nil];
    return checkArray;
}

// method to book room

+ (void)bookRoomMethod:(NSDate *)endDate startDate:(NSDate *)startDate email:(Room *)room firstNameField:(UITextField *)nameField lastNameField:(UITextField *)lastNameField emailField:(UITextField *)emailField phoneField:(UITextField *)phoneField completion:(ReservationServiceCompletion)completion
{
    // abstract away: creating reservation name fields
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate room:room];
    
    room.reservation = reservation;
    reservation.guest = [Guest guestWithName:nameField.text lastName:lastNameField.text email:emailField.text phone:phoneField.text]; // passing in name to create guest name
    
    NSError *error;
    [[NSObject managerContext] save:&error];
    
    if (error) {
        NSLog(@"Save error: %@", error);
    }
    
    else {
        completion();
    }
}


@end
