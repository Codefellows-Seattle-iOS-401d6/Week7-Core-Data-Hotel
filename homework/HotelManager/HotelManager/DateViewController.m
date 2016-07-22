//
//  DateViewController.m
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property(strong, nonatomic)UIDatePicker *endPicker;
@property(strong, nonatomic)UIDatePicker *startPicker;
@property(strong, nonatomic)UILabel *startLabel;
@property(strong, nonatomic)UILabel *endLabel;

@end

@implementation DateViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDateViewController];
    [self setupDatePickers];
    [self setupDateLabels];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupDateViewController
{
    [self.navigationItem setTitle:@"Select Dates"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

- (void)setupDateLabels
{
    self.startLabel = [[UILabel alloc]init];
    self.startLabel.text = @"Start Date";
    [self.startLabel setTextAlignment:NSTextAlignmentCenter];
    self.startLabel.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), 15.0);
    [self.view addSubview:self.startLabel];
    
    self.endLabel = [[UILabel alloc]init];
    self.endLabel.text = @"End Date";
    [self.endLabel setTextAlignment:NSTextAlignmentCenter];
    self.endLabel.frame = CGRectMake(0.0, ((CGRectGetHeight(self.view.frame) *2) / 3) - 66.0, CGRectGetWidth(self.view.frame), 15.0);
    [self.view addSubview:self.endLabel];
    
    
}
- (void)setupDatePickers
{
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    self.startPicker.frame = CGRectMake(0.0, 100.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 3);
    
    [self.view addSubview:self.startPicker];
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    self.endPicker.frame = CGRectMake(0.0, ((CGRectGetHeight(self.view.frame) * 2)/ 3) - 50.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) / 3);
    [self.view addSubview:self.endPicker];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender
{
    NSDate *endDate = [self.endPicker date];
    NSDate *startDate = [self.startPicker date];
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hmmm...." message:@"Please make sure end date is in the future of start date..." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
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
