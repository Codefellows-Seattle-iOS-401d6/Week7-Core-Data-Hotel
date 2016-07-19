//
//  NSObject+NSManagedObject.h
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface NSObject (NSManagedObject)

+ (NSManagedObjectContext *)managerContext;

@end
