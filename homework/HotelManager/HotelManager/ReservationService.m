//
//  ReservationService.m
//  HotelManager
//
//  Created by Sung Kim on 7/20/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"


@implementation ReservationService

- (NSArray *)checkAvailabilityWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSArray *datasource = [[NSArray alloc]init];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    
    NSError *error;
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error with fetch...");
    }
    else {
        NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
        for (Reservation *reservation in results) {
            [unavailableRooms addObject:reservation.room];
        }
        
        NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
        checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
        
        NSError *availableError;
        datasource = [delegate.managedObjectContext executeFetchRequest:checkRequest error:&availableError];
        
        if (availableError) {
            NSLog(@"Error with second fetch...");
        }
        else {
            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
            datasource = [datasource sortedArrayUsingDescriptors:@[sort]];
        }
    }
    return datasource;
}

-(NSFetchedResultsController *)findAllReservations:(NSFetchRequest *)request
{
    request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"guest.firstName" ascending:YES]];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext managerContext] sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    [fetchedResultsController performFetch:&error];
    
    if (error) {
        NSLog(@"Fetch Error: %@", error.localizedDescription);
    }
    else {
        NSLog(@"Fetch successful!");
    }
    
    return fetchedResultsController;
}

- (BOOL)saveReservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room guest:(Guest *)guest
{
    Reservation *reservation = [Reservation reservationWithStartDate:startDate endDate:endDate room:room];

    room.reservation = reservation;
    
    reservation.guest = guest;
    
    NSError *error;
    [[NSManagedObjectContext managerContext] save:&error];
    
    if (error) {
        return NO;
    }
    else {
        return YES;
    }
    
}
@end
