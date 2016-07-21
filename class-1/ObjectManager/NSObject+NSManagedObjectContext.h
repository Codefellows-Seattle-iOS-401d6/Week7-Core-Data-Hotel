//
//  NSObject+NSManagedObjectContext.h
//  ObjectManager
//
//  Created by Derek Graham on 7/19/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface NSObject (NSManagedObjectContext)
+ (NSManagedObjectContext *)managerContext;

@end
