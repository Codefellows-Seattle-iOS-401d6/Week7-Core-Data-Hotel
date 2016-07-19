//
//  BookViewController.m
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//


#import "BookViewController.h"

#import "NSObject+NSManagedObject.h"

@interface BookViewController ()

@property(strong, nonatomic) UITextField *nameField;

@end

@implementation BookViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupBookViewController];
    
    [self setupMessageLabel];
    
    [self setupNameField];
}

- (void)setupBookViewController
{
    [self.navigationItem setTitle:self.room.hotel.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveButtonSelected:)]];
}

- (void)setupNameField
{
    self.nameField = [[UITextField alloc]init];
    
    self.nameField.placeholder = @"Please enter your name.";
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.nameField];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.nameField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.nameField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:84.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.nameField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-20.0];
    
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    
    
}

- (void)setupMessageLabel
{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From:Start Date - Tol %@",self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]]; // just showing date and no time!
    
    [self.view addSubview:messageLabel];
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-20.0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1.0
                                                                constant:0.0];
    
    leading.active = YES;
    trailing.active = YES;
    centerY.active = YES;
    
    [self.nameField becomeFirstResponder];
    
}

- (void)saveButtonSelected:(UIBarButtonItem *)sender
{
    // TODO -
    Reservation *reservation = [Reservation reservationWithStartDate:[NSDate date] endDate:self.endDate room:self.room];
    
    self.room.reservation = reservation;
    reservation.guest = [Guest guestWithName:self.nameField.text]; // passing in name to create guest name
    
    NSError *error;
    [[NSObject managerContext] save:&error];
    
    if (error) {
        NSLog(@"Save error: %@", error);
    }
    else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
