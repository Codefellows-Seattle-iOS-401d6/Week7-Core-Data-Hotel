//
//  Guest.m
//  Manager-Class-2
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSObject+NSObjectContext.h"
#import "AppDelegate.h"

@implementation Guest

+(instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
    
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    
    return guest;
    
}

@end
