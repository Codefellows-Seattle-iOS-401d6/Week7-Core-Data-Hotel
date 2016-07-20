//
//  NSManagedObjectContext+NSObject.m
//  Manager
//
//  Created by Jess Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "NSManagedObjectContext+NSObject.h"
#import "AppDelegate.h"

@implementation NSManagedObjectContext (NSObject)


+(NSManagedObjectContext *)managerContext
{
    AppDelegate *delegate =[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}


@end
