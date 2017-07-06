//
//  DatePickerViewController.m
//  Manager
//
//  Created by David Livingstone on 7/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "DatePickerViewController.h"
#import "AvailableRoomsViewController.h"

@interface DatePickerViewController ()

//@property(strong, nonatomic)UILabel *startLabel;
@property(strong, nonatomic)UIDatePicker *startPicker;
@property(strong, nonatomic)UIDatePicker *endPicker;

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupDatePickerViewController];
    [self setupDatePickers];
}

-(void)setupDatePickerViewController{
    [self.navigationItem setTitle:@"Select Dates"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupDatePickers{
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 90.0, self.view.frame.size.width, 30.0)];
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 400.0, self.view.frame.size.width, 30.0)];
    
    self.startPicker = [[UIDatePicker alloc]init];
    self.endPicker = [[UIDatePicker alloc]init];
    
    startLabel.text = @"Start Date:";
    endLabel.text = @"End Date:";
    
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    self.startPicker.frame = CGRectMake(20.0, 120.0, self.view.frame.size.width, 200.0);
    self.endPicker.frame = CGRectMake(20.0, 430.0, self.view.frame.size.width, 200.0);
    
    [self.view addSubview:startLabel];
    [self.view addSubview:endLabel];
    [self.view addSubview:self.startPicker];
    [self.view addSubview:self.endPicker];
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender{
    
    NSDate *startDate = [self.startPicker date];
    NSDate *endDate = [self.endPicker date];
    
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [startDate timeIntervalSinceReferenceDate] || [[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Please select dates in the futre" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.endPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
        
    }
    
    AvailableRoomsViewController *availableRoomsViewController = [[AvailableRoomsViewController alloc] init];
    
    availableRoomsViewController.start = startDate;
    availableRoomsViewController.end = endDate;
    
    [self.navigationController pushViewController:availableRoomsViewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
