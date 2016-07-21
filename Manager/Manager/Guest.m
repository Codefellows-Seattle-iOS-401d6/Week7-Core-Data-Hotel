//
//  Guest.m
//  Manager
//
//  Created by Erin Roby on 7/18/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSObject+NSManagedObjectContext.h"
#import "AppDelegate.h"

@implementation Guest

+(instancetype)guestInitWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email {
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
    
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    
    return guest;
}

@end
