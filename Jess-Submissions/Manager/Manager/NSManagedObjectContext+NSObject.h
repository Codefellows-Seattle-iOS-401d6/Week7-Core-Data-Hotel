//
//  NSManagedObjectContext+NSObject.h
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface NSManagedObjectContext (NSObject)

+(NSManagedObjectContext *)managerContext;

@end
