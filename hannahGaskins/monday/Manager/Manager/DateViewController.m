//
//  DateViewController.m
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"


@interface DateViewController ()

@property(strong, nonatomic)UIDatePicker *endPicker;
// TODO!!!! Add startPicker
@property(strong, nonatomic)UIDatePicker *startPicker;
@end

@implementation DateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupDateViewController];
    [self setupDatePickers];
    
}

- (void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupDateViewController
{
    [self.navigationItem setTitle:@"Select Start and End Dates"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
    
}

- (void)setupDatePickers
{
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    self.startPicker.frame = CGRectMake(0.0, (84.0 + CGRectGetHeight(self.view.frame)/3), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
    [self.view addSubview:self.startPicker];
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    self.endPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
    [self.view addSubview:self.endPicker];
    
    
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender
{
    NSDate *startDate = [self.endPicker date];
    NSDate *endDate = [self.startPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hmm..." message:@"Please make sure end date is in the future..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.endPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated: YES completion: nil];
        
        return;
    }
    
    // instantiating availabilityVC
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    
    availabilityViewController.startDate = startDate;

    availabilityViewController.endDate = endDate;
    
    [self.navigationController pushViewController:availabilityViewController animated:YES];
}
    
    



@end
