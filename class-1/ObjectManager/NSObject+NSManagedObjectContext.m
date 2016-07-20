//
//  NSObject+NSManagedObjectContext.m
//  ObjectManager
//
//  Created by Derek Graham on 7/19/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate.h"

@import CoreData;

@implementation NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                                            
    return delegate.managedObjectContext;
}
@end
