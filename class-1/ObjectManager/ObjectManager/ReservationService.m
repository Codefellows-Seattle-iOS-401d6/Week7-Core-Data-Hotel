//
//  ReservationService.m
//  ObjectManager
//
//  Created by Derek Graham on 7/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "ReserveViewController.h"
#import "LookupViewController.h"

#import "AppDelegate+CoreDataStack.h"

@implementation ReservationService


- (NSArray *)checkAvailability: (NSDate *)endDate startDate:(NSDate *)startDate
{
    
NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        
request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, [NSDate date]];
    
    
//    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
//
    
        NSArray *results = [[AppDelegate managedObjectContext] executeFetchRequest:request error:nil];
        
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        for (Reservation *reservation in results){
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        
        checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        return [AppDelegate.managedObjectContext executeFetchRequest:checkRequest error:nil];
}

- (NSFetchedResultsController *)showAllReservations
{
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"room.reservation.guest.firstName" ascending:YES]];
    
    NSFetchedResultsController *returnfetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:AppDelegate.managedObjectContext  sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    [returnfetchedResultsController performFetch:&error];
    
    if (error){
        NSLog(@"%@", error.localizedDescription);
    }
    else {
        NSLog(@"Reservation fetch success");
    }
    
    return returnfetchedResultsController;
}
- (BOOL )bookRoomStarting: (NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room guest:(Guest *)guest
{
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate room:room];
    
    room.reservation = reservation;
    
    reservation.guest = guest;
    
    NSError *error;
    [AppDelegate.managedObjectContext save: &error];
    
    if (error) {
        return NO;
    }
    
    else {
        return YES;
    }
}

@end
