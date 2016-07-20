//
//  BookViewController.h
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Reservation.h"
#import "Hotel.h"
#import "Guest.h"


@interface BookViewController : UIViewController
@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
