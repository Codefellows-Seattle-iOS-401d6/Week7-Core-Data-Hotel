//
//  BookViewController.h
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Guest.h"

@interface BookViewController : UIViewController

@property(strong, nonatomic)Room *room;
@property(strong, nonatomic)NSDate *endDate;
@property(strong, nonatomic)NSDate *startDate;


@end
