//
//  ReservationService.h
//  Manager-Class-2
//
//  Created by Sean Champagne on 7/20/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "BookViewController.h"
#import "AvailabilityViewController.h"
#import "DateViewController.h"
#import "BookViewController.h"
#import "LookupViewController.h"
#import "HotelsViewController.h"
#import "ViewController.h"
#import "Hotel.h"
#import "Guest.h"
#import "Room.h"
#import "Reservation.h"
#import "AppDelegate.h"
#import "NSObject+NSObjectContext.h"

@interface ReservationService : NSObject

+(NSArray *)reservationService:(NSDate *)startDate endDate:(NSDate *)endDate;
+(Reservation *)bookHotel:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room nameField:(UITextField *)nameField lastNameField:(UITextField *)lastNameField email:(UITextField *)emailField;

@end
