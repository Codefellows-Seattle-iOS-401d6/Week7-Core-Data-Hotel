//
//  BookViewController.h
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Guest.h"

@interface BookViewController : UIViewController

@property (strong, nonatomic)Room *room;
@property (strong, nonatomic)NSDate *startDate;
@property (strong, nonatomic)NSDate *endDate;

@end
