//
//  AvailabilityViewController.h
//  Manager
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReservationService.h"

@interface AvailabilityViewController : UIViewController

@property (strong, nonatomic) NSDate *startDate;
@property (strong, nonatomic) NSDate *endDate;

@end
