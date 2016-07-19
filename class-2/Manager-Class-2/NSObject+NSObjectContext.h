//
//  NSObject+NSObjectContext.h
//  Manager-Class-2
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface NSObject (NSManagedObjectContext)

+ (NSManagedObjectContext *)managerContext;

@end
