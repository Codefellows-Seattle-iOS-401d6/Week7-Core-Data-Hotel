//
//  ReservationService.h
//  Hotel
//
//  Created by Rick  on 7/20/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Hotel.h"

@interface ReservationService : NSObject

+ (NSArray *)reservationRequest:(NSDate *)endDate startDate:(NSDate *)startDate;

+ (NSFetchedResultsController *)fetchRequest:(NSString *)entityName sortKey:(NSString *)sortKey;

+ (NSArray *)lookupRequest:(NSString *)searchText;


@end
