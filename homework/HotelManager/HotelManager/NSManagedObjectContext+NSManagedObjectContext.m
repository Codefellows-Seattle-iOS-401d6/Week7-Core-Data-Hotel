//
//  NSManagedObjectContext+NSManagedObjectContext.m
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "NSManagedObjectContext+NSManagedObjectContext.h"
#import "AppDelegate.h"

@implementation NSManagedObjectContext (NSManagedObjectContext)

+ (NSManagedObjectContext *)managerContext
{
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    return delegate.managedObjectContext;
}

@end
