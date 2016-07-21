//
//  Guest.m
//  Manager
//
//  Created by Sean Champagne on 7/18/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"

#import "NSObject+NSManagedObjectContext.h"

@implementation Guest

// Insert code here to add functionality to your managed object subclass

+(instancetype)guestWithName:(NSString *)name
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];

    guest.name = name;
    
    return guest;

}

@end
