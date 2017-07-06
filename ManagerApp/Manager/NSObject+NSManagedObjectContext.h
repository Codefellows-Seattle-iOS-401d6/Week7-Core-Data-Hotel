//
//  NSObject+NSManagedObjectContext.h
//  Manager
//
//  Created by David Livingstone on 7/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext;

@end
