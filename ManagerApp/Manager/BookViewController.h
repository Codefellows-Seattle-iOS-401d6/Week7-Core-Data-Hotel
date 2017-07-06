//
//  BookViewController.h
//  Manager
//
//  Created by David Livingstone on 7/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Guest.h"

@interface BookViewController : UIViewController

@property(strong, nonatomic)Room *room;
@property(strong, nonatomic)NSDate *end;

@end
