//
//  ReservationService.h
//  Manager
//
//  Created by Erin Roby on 7/20/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"

#import "BookViewController.h"
#import "AvailabilityViewController.h"
#import "DateViewController.h"
#import "BookViewController.h"
#import "LookupViewController.h"
#import "HotelsViewController.h"
#import "ViewController.h"

#import "Hotel.h"
#import "Room.h"
#import "Reservation.h"
#import "Guest.h"

#import "NSObject+NSManagedObjectContext.h"

@interface ReservationService : NSObject

+(NSArray *)reservationService:(NSDate *)startDate endDate:(NSDate *)endDate;
+(Reservation *)bookHotel:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room nameField:(UITextField *)nameField lastNameField:(UITextField *)lastNameField email:(UITextField *)emailField;

@end
