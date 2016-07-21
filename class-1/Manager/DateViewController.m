//
//  DateViewController.m
//  Manager
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property (strong, nonatomic) UIDatePicker *startPicker;
@property (strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupDateViewController];
    [self setupDatePickers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupDateViewController
{
    [self.navigationItem setTitle:@"Select End Date"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonSelected)]];
}

-(void) setupDatePickers
{ //need to set it as point based, not frame based.
    
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
   
   // self.startPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
   // [self.view addSubview:self.startPicker];
    
    
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    self.endPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));

    [self.view addSubview:self.endPicker];
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender
{
    NSDate *endDate = [self.endPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hmmm...." message:@"Please make sure end date is after start date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.endPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    
    [self.navigationController pushViewController:availabilityViewController animated:YES];
    
    }

-(void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

@end
