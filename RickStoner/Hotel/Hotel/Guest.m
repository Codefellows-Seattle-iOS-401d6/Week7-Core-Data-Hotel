//
//  Guest.m
//  Hotel
//
//  Created by Rick  on 7/18/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"

@implementation Guest

+ (instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
    
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    
    return guest;
}

@end
