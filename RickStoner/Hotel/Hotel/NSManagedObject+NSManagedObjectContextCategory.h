//
//  NSManagedObject+NSManagedObjectContextCategory.h
//  Hotel
//
//  Created by Rick  on 7/19/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface NSManagedObject (NSManagedObjectContextCategory)

+ (NSManagedObjectContext *)managedContext;

@end
