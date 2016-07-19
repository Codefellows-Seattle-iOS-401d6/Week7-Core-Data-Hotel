//
//  DateViewController.m
//  Hotel
//
//  Created by Rick  on 7/19/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property (strong, nonatomic)UIDatePicker *endPicker;
@property (strong, nonatomic)UIDatePicker *startPicker;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDateViewController];
    [self setupDatePickers];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupDateViewController {
    [self.navigationItem setTitle:@"Select Start Date and End Date"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

- (void)setupDatePickers{
    self.endPicker = [[UIDatePicker alloc]init];
    self.startPicker = [[UIDatePicker alloc]init];
    
    self.startPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), 150.0);
    self.endPicker.frame = CGRectMake(0.0, 244.0, CGRectGetWidth(self.view.frame), 100.0);
    
    [self.view addSubview:self.startPicker];
    [self.view addSubview:self.endPicker];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender{
    NSDate *startDate = [self.startPicker date];
    NSDate *endDate = [self.endPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Dates" message:@"Please ensure you start an end date after your start date." preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.startPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion: nil];
        
        return;
    }
    
    NSLog(@"Start Date: %@, End Date: %@", startDate, endDate);
}

@end
