//
//  NSManagedObject+ManagedContext.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "NSManagedObject+ManagedContext.h"
#import "AppDelegate.h"

@implementation NSManagedObject (ManagedContext)

+(NSManagedObjectContext *) managedContext {
    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    return delegate.managedObjectContext;
}

@end
