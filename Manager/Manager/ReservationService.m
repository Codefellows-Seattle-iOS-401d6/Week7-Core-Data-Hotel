//
//  ReservationService.m
//  Manager
//
//  Created by Erin Roby on 7/20/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "ReservationService.h"

@implementation ReservationService

+(NSArray *)reservationService:(NSDate *)startDate endDate:(NSDate *)endDate
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSArray *array;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:nil];
    
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
    
    for (Reservation *reservation in results)
    {
        [unavailableRooms addObject:reservation.room];
    }
    NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    
    checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    array = [delegate.managedObjectContext executeFetchRequest:checkRequest error:nil];
    
    return array;
}

+(Reservation *)bookHotel:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room nameField:(UITextField *)nameField lastNameField:(UITextField *)lastNameField email:(UITextField *)emailField
{
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate room:room];
    
    room.reservation = reservation;
    
    reservation.room.reservation = reservation;
    reservation.guest = [Guest guestInitWithName:nameField.text lastName:lastNameField.text email:emailField.text];
    return reservation;
}

@end
