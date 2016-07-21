//
//  NSObject+NSManagedObjectContext.m
//  Manager
//
//  Created by Erin Roby on 7/19/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate.h"

@implementation NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

@end
