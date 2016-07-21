//
//  Guest.m
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "AppDelegate.h"
#import "NSObject+NSManagedObjectContext.h"

@implementation Guest

// Insert code here to add functionality to your managed object subclass

+(instancetype)guestWithNameAndEmail:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email payment:(NSString *)payment notes:(NSString *)notes{
//    AppDelegate *delegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSObject managerContext]];
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    guest.payment = payment;
    guest.notes = notes;
    
    return guest;
}

@end
