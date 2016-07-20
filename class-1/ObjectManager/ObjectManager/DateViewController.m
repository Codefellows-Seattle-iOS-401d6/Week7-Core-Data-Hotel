//
//  DateViewController.m
//  ObjectManager
//
//  Created by Derek Graham on 7/19/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "DateViewController.h"
#import "AvailabilityViewController.h"

@interface DateViewController ()

@property (strong, nonatomic) UIDatePicker *startPicker;

@property (strong, nonatomic) UIDatePicker *endPicker;

@end

@implementation DateViewController

- (void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor orangeColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDateViewController];
    [self setupDatePickers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupDateViewController{
    [self.navigationItem setTitle:@"Select End Date"];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonSelected:)]];
    
    
}

- (NSDate *)dateDaysFromToday: (NSNumber *)days {
    unsigned int flags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:flags fromDate:[NSDate date]];
    NSDate* dateOnly = [calendar dateFromComponents:components];
    
    
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    dayComponent.day = days.longValue;
    return [theCalendar dateByAddingComponents:dayComponent toDate:dateOnly options:0];
}
- (NSDate *)dateDaysFromDate: (NSNumber *)days date:(NSDate *)fromDate{
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    dayComponent.day = days.longValue;
    return [theCalendar dateByAddingComponents:dayComponent toDate:fromDate options:0];
}

- (void) setupDatePickers {
    self.startPicker = [[UIDatePicker alloc]init];
    self.startPicker.datePickerMode = UIDatePickerModeDate;
    self.endPicker = [[UIDatePicker alloc]init];
    self.endPicker.datePickerMode = UIDatePickerModeDate;

    self.startPicker.date = [self dateDaysFromToday:@1];
    

    self.endPicker.date = [self dateDaysFromToday:@5];
    
    CGFloat pickerHeight = CGRectGetHeight(self.view.frame) / 2.5;
    self.startPicker.frame = CGRectMake(0.0, 84.0, CGRectGetWidth(self.view.frame), pickerHeight);

    
    self.endPicker.frame = CGRectMake(0.0, 84.0 + pickerHeight, CGRectGetWidth(self.view.frame), pickerHeight);
    
    [self.view addSubview:self.startPicker];

    [self.view addSubview:self.endPicker];
    
    
}

- (void) doneButtonSelected:(UIBarButtonItem *)sender {
    NSDate *endDate = [self.endPicker date];
    NSDate *startDate = [self.startPicker date];
    
    if ([[NSDate date] timeIntervalSinceReferenceDate] > [endDate timeIntervalSinceReferenceDate] ||
        [[NSDate date] timeIntervalSinceReferenceDate] > [startDate timeIntervalSinceReferenceDate] ||
        [startDate timeIntervalSinceReferenceDate] >= [endDate timeIntervalSinceReferenceDate]
        
        ){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Hmmnnnn" message:@"Please make sure start and end date are in the future..." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ( [startDate timeIntervalSinceReferenceDate] <= [[NSDate date] timeIntervalSinceReferenceDate] ) {
                self.startPicker.date = [self dateDaysFromToday:@1];
                
            }
            
            NSLog(@"date intervals: start: %f, end: %f", [startDate timeIntervalSinceReferenceDate], [endDate timeIntervalSinceReferenceDate]);
            if ( [[NSDate date] timeIntervalSinceReferenceDate] >= [endDate timeIntervalSinceReferenceDate] || [startDate timeIntervalSinceReferenceDate] == [endDate timeIntervalSinceReferenceDate] ) {
                self.endPicker.date = [self dateDaysFromDate:@3 date:self.startPicker.date];
            }
//            self.endPicker.date = [NSDate date];
            
            
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    
    AvailabilityViewController *availabilityViewController = [[AvailabilityViewController alloc] init];
    
    availabilityViewController.endDate = endDate;
    
    [self.navigationController pushViewController:availabilityViewController animated:YES];
    
    
}

@end
