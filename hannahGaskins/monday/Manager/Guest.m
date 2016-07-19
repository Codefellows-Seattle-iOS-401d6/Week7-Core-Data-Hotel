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

+ (instancetype)guestWithName:(NSString *)name
{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSObject managerContext]];
    
    guest.name = name;
    return guest;
}


@end
