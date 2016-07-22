//
//  DateViewController.m
//  Manager
//
//  Created by Jessica Malesh on 7/19/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property (strong, nonatomic)UIDatePicker *startPicker;
@property (strong, nonatomic)UIDatePicker *endPicker;

@end

@implementation DateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDateViewController];
    [self setupDatePickers];
   
}

- (void)setupDateViewController
{
    [self.navigationItem setTitle:@"Select Dates"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

- (void)setupDatePickers
{
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    self.endPicker.frame = CGRectMake(0.0, 260.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 2);
   
    [self.view addSubview:self.endPicker];
    
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    
    self.startPicker.frame = CGRectMake(0.0, 20.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 2);
    [self.view addSubview:self.startPicker];
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender
{
    NSDate *startDate = [self.startPicker date];
    NSDate *endDate = [self.endPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hmmm...." message:@"Please make sure end data is a date in the future" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             self.endPicker.date = [NSDate date];
                                                         }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    availabilityViewController.endDate = endDate;
    availabilityViewController.startDate = startDate;
    
    [self.navigationController pushViewController:availabilityViewController animated:YES];
}

@end





















