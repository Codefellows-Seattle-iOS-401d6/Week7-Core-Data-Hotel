//
//  NSObject+NSManagedObject.m
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "NSObject+NSManagedObject.h"
#import "AppDelegate.h"

@implementation NSObject (NSManagedObject)

+ (NSManagedObjectContext *)managerContext
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

@end
