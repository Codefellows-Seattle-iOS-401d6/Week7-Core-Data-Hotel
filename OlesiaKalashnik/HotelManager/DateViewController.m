//
//  DateViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()
@property (strong, nonatomic) UIDatePicker *endPicker;
@property (strong, nonatomic) UIDatePicker *startPicker;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDateVC];
    [self setupDatePickers];
}

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupDateVC {
    [self.navigationItem setTitle: @"Select Start and End Dates"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}


-(void)setupDatePickers {
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 70.0, (self.view.frame.size.width - 40.0), 30.0)];
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.text = @"Start date";
    startLabel.textColor = [UIColor blackColor];
    [self.view addSubview: startLabel];
    //make this constraint based, not frame based
    self.startPicker.frame = CGRectMake(0.0, 70.0 + startLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
    [self.view addSubview: self.startPicker];
    
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 70.0 + startLabel.frame.size.height + self.startPicker.frame.size.height, (self.view.frame.size.width - 40.0), 30.0)];
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.text = @"End date";
    endLabel.textColor = [UIColor blackColor];
    [self.view addSubview: endLabel];
    //make this constraint based, not frame based
    self.endPicker.frame = CGRectMake(0.0, 70.0 + startLabel.frame.size.height + self.startPicker.frame.size.height + endLabel.frame.size.height, self.view.frame.size.width, self.view.frame.size.height/3);
    [self.view addSubview: self.endPicker];
}

-(void)doneButtonSelected: (UIBarButtonItem *)sender {
    NSDate *endDate = [self.endPicker date];
    NSDate *startDate = [self.startPicker date];
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid date"  message:@"Please pick valid date" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action) {
            self.endPicker.date = [NSDate date];
            self.startPicker.date = [NSDate date];

        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    AvailabilityViewController *availabilityVC = [[AvailabilityViewController alloc]init];
    availabilityVC.endDate = endDate;
    availabilityVC.startDate = startDate;

    [self.navigationController pushViewController:availabilityVC animated: YES];
}


@end
