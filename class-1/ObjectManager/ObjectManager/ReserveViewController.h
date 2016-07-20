//
//  ReserveViewController.h
//  ObjectManager
//
//  Created by Derek Graham on 7/19/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface ReserveViewController : UIViewController

@property (strong, nonatomic) Room *room;
@property (strong, nonatomic) NSDate *endDate;
@property (strong, nonatomic) NSDate *startDate;


@end
