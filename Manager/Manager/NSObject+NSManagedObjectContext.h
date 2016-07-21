//
//  NSObject+NSManagedObjectContext.h
//  Manager
//
//  Created by Erin Roby on 7/19/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface NSObject (NSManagedObjectContext)

+(NSManagedObjectContext *)managerContext;

@end
