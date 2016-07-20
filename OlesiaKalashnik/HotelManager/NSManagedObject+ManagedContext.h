//
//  NSManagedObject+ManagedContext.h
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ManagedContext)
+(NSManagedObjectContext *) managedContext;
@end
