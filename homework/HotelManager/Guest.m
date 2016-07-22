//
//  Guest.m
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"

@implementation Guest

+ (instancetype)guestWithName:(NSString *)name lastName:(NSString *)lastName email:(NSString *)email
{
    Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[NSManagedObjectContext managerContext]];
    
    guest.firstName = name;
    guest.lastName = lastName;
    guest.email = email;
    
    return guest;
}
@end
