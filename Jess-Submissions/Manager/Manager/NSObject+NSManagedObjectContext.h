//
//  NSObject+NSManagedObjectContext.h
//  Manager
//
//  Created by Jessica Malesh on 7/20/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext;

@end
