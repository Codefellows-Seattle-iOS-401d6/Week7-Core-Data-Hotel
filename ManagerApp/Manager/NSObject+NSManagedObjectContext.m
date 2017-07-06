//
//  NSObject+NSManagedObjectContext.m
//  Manager
//
//  Created by David Livingstone on 7/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate.h"

@implementation NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

@end
