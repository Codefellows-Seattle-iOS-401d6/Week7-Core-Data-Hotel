//
//  Guest.m
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#include "NSManagedObjectContext+NSObject.h"

@implementation Guest

+ (instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email
{
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    
    return guest;
    
    
}


@end
