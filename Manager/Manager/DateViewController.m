//
//  DateViewController.m
//  Manager
//
//  Created by Erin Roby on 7/19/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
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
    [self setupDateViewController];
    [self setupDatePickers];
}

-(void)loadView{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupDateViewController{
    [self.navigationItem setTitle:@"Please select Check-in & Check-out Dates"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

-(void)setupDatePickers{
    // Check in:
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    
    UILabel *startLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 70.0, (self.view.frame.size.width - 40.0), 30.0)];
    startLabel.textAlignment = NSTextAlignmentLeft;
    startLabel.text = @"Check in:";
    startLabel.textColor = [UIColor blackColor];
    [self.view addSubview: startLabel];
    self.startPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
    [self.view addSubview: self.startPicker];
    
    // Check out:
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;
    
    UILabel *endLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0, 70.0 + startLabel.frame.size.height + self.startPicker.frame.size.height, (self.view.frame.size.width - 40.0), 30.0)];
    endLabel.textAlignment = NSTextAlignmentLeft;
    endLabel.text = @"Check out:";
    endLabel.textColor = [UIColor blackColor];
    [self.view addSubview: endLabel];
    
    self.endPicker.frame = CGRectMake(0.0, (84.0 + CGRectGetHeight(self.view.frame)/2.5), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)/3);
    [self.view addSubview: self.endPicker];
}

-(void)doneButtonSelected:(UIBarButtonItem *)sender{
    NSDate *endDate = [self.endPicker date];
    NSDate *startDate = [self.startPicker date];
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"oh no!"  message:@"Pick a future date, please..." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"Ok" style: UIAlertActionStyleDefault handler: ^(UIAlertAction *_Nonnull action) {
            self.endPicker.date = [NSDate date];
            self.startPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    availabilityViewController.startDate = startDate;
    availabilityViewController.endDate = endDate;
    
    
    [self.navigationController pushViewController:availabilityViewController animated: YES];
}

@end