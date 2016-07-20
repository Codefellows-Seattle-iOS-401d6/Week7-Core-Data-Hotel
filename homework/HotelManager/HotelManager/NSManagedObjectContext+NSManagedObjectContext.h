//
//  NSManagedObjectContext+NSManagedObjectContext.h
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import <CoreData/CoreData.h>
@import CoreData;

@interface NSManagedObjectContext (NSManagedObjectContext)

+ (NSManagedObjectContext *)managerContext;

@end
