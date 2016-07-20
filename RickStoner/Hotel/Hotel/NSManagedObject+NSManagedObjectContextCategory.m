//
//  NSManagedObject+NSManagedObjectContextCategory.m
//  Hotel
//
//  Created by Rick  on 7/19/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "NSManagedObject+NSManagedObjectContextCategory.h"

@implementation NSManagedObject (NSManagedObjectContextCategory)

+ (NSManagedObjectContext *)managedContext {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    return delegate.managedObjectContext;
}

@end
