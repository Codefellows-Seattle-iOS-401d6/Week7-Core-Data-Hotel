//
//  Guest.m
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Guest

+(instancetype)guestWithEmail:(NSString *)email first:(NSString *)first last:(NSString *)last {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
    
    guest.email = email;
    guest.first = first;
    guest.last = last;

    return guest;
}

@end