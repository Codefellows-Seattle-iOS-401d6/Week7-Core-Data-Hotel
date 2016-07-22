//
//  Guest.m
//  Manager
//
//  Created by hannah gaskins on 7/18/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"

#import "NSObject+NSManagedObject.h"

@implementation Guest

+ (instancetype)guestWithName:(NSString *)firstName lastName:(NSString *)lastName email:(NSString *)email phone:(NSString *)phone
{
//    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSObject managerContext]];
    
    guest.firstName = firstName;
    guest.lastName = lastName;
    guest.email = email;
    guest.phone = phone;
    
    return guest;
}


@end
