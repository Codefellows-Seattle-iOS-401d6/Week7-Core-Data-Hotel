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
    [self setupPickerLabels];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupDateViewController {
    [self.navigationItem setTitle:@"Select Dates"];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
}

- (void)setupPickerLabels {
    UILabel *startLabel = [[UILabel alloc]init];
    UILabel *endLabel = [[UILabel alloc]init];
    
    startLabel.textAlignment = NSTextAlignmentCenter;
    startLabel.numberOfLines = 1;
    
    endLabel.textAlignment = NSTextAlignmentCenter;
    endLabel.numberOfLines = 1;
    
    startLabel.translatesAutoresizingMaskIntoConstraints = NO;
    endLabel.translatesAutoresizingMaskIntoConstraints = NO;

    
    startLabel.text = @"Start Date";
    endLabel.text = @"End Date";
    
    [self.view addSubview:startLabel];
    [self.view addSubview:endLabel];
    
    NSLayoutConstraint *leadingStart = [NSLayoutConstraint constraintWithItem:startLabel
                                                             attribute:NSLayoutAttributeLeading
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.view
                                                              attribute:NSLayoutAttributeLeading
                                                             multiplier:1.0
                                                                     constant:20.0];
    NSLayoutConstraint *trailingStart = [NSLayoutConstraint constraintWithItem:startLabel
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0 constant:20.0];
    NSLayoutConstraint *topStart = [NSLayoutConstraint constraintWithItem:startLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTop
                                                               multiplier:1.0 constant:74.0];
    NSLayoutConstraint *leadingEnd = [NSLayoutConstraint constraintWithItem:endLabel
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:20.0];
    NSLayoutConstraint *trailingEnd = [NSLayoutConstraint constraintWithItem:endLabel
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0 constant:20.0];
    NSLayoutConstraint *topEnd = [NSLayoutConstraint constraintWithItem:endLabel
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0 constant:284.0];
    
    trailingStart.active = YES;
    leadingStart.active = YES;
    topStart.active = YES;
    trailingEnd.active = YES;
    leadingEnd.active = YES;
    topEnd.active = YES;
    
}

- (void)setupDatePickers{
    self.endPicker = [[UIDatePicker alloc]init];
    self.startPicker = [[UIDatePicker alloc]init];
    
    self.startPicker.frame = CGRectMake(0.0, 94.0, CGRectGetWidth(self.view.frame), 150.0);
    self.endPicker.frame = CGRectMake(0.0, 304.0, CGRectGetWidth(self.view.frame), 150.0);
    
    [self.view addSubview:self.startPicker];
    [self.view addSubview:self.endPicker];
}

- (void)doneButtonSelected:(UIBarButtonItem *)sender{
    NSDate *startDate = [self.startPicker date];
    NSDate *endDate = [self.endPicker date];
    NSLog(@"%f", [startDate timeIntervalSinceNow]);
    
    if ([startDate timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate] || [startDate timeIntervalSinceNow] < -120 ) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Invalid Dates" message:@"Please ensure a valid start date and end date." preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.startPicker.date = [NSDate date];
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion: nil];
        
        return;
    }
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc]init];
    availabilityViewController.startDate = startDate;
    availabilityViewController.endDate = endDate;
    [self.navigationController pushViewController:availabilityViewController animated:YES];
}

@end
