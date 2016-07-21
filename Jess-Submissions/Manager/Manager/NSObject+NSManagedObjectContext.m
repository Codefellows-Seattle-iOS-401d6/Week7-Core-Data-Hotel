//
//  NSObject+NSManagedObjectContext.m
//  Manager
//
//  Created by Jessica Malesh on 7/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate.h"

@implementation NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext{
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
    
}


@end
