//
//  ReservationService.m
//  Hotel
//
//  Created by Rick  on 7/20/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "ReservationService.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "NSManagedObject+NSManagedObjectContextCategory.h"
#import "Flurry.h"

@interface ReservationService () <NSFetchedResultsControllerDelegate>

@end

@implementation ReservationService


+ (NSArray *)reservationRequest:(NSDate *)endDate startDate:(NSDate *)startDate{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", endDate, startDate];
    NSError *error;
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    
    if(error) {
        NSLog(@"Reservation fetch request failed: Error: %@", error);
    }
    
    NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
    for (Reservation *reservation in results) {
        [unavailableRooms addObject:reservation.room];
    }
    
    NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
    checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
    
    NSError *checkError;
    NSArray *datasource = [delegate.managedObjectContext executeFetchRequest:checkRequest error:&checkError];
    
    if(checkError){
        NSLog(@"Error with Room check request. Error: %@", checkError);
    }
    return datasource;
}

+ (NSFetchedResultsController *)fetchRequest:(NSString *)entityName sortKey:(NSString *)sortKey {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    request.sortDescriptors =@[[NSSortDescriptor sortDescriptorWithKey:sortKey ascending:YES]];
    
    NSFetchedResultsController *fetchResults = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[NSManagedObject managedContext] sectionNameKeyPath:nil cacheName:nil];
    
    NSError *error;
    [fetchResults performFetch:&error];
    
    if (error) {
        NSLog(@"Error with hotel fetch. Error: %@", error.localizedDescription);
    }
    return fetchResults;
}

+ (NSArray *)lookupRequest:(NSString *)searchText{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.firstName CONTAINS %@ || guest.lastName CONTAINS %@", searchText, searchText];
    
    NSError *error;
    NSArray *results = [[NSManagedObject managedContext] executeFetchRequest:request error:&error];
    [Flurry logEvent:[NSString stringWithFormat:@"Lookup request with search of %@", searchText]];
    if (error) {
        NSLog(@"Error fetching desired request. Error: %@", error);
        return nil;
    } else {
        return results;
        
    }
}




@end
