//
//  BookViewController.m
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "BookViewController.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"
#import "ReservationService.h"


@interface BookViewController ()

@property(strong, nonatomic)UITextField *nameField;
@property(strong, nonatomic)UITextField *lastNameField;
@property(strong, nonatomic)UITextField *emailField;

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
    [self setupNameField];
    [self setupLastNameField];
    [self setupEmailField];
    [self setupMessageLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupBookViewController
{
    [self.navigationItem setTitle:self.room.hotel.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

- (void)setupNameField
{
    self.nameField = [[UITextField alloc]init];
    
    self.nameField.placeholder = @"Please enter your first name.";
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
                                                                constant:20.0];
    
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    
    [self.nameField becomeFirstResponder];
}

- (void)setupLastNameField
{
    self.lastNameField = [[UITextField alloc]init];
    
    self.lastNameField.placeholder = @"Please enter your last name.";
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.lastNameField];
    
    NSLayoutConstraint *lastLeading = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    NSLayoutConstraint *lastTop = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.nameField
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:10.0];
    NSLayoutConstraint *lastTrailing = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:20.0];
    
    lastLeading.active = YES;
    lastTop.active = YES;
    lastTrailing.active = YES;
}

- (void)setupEmailField
{
    self.emailField = [[UITextField alloc]init];
    
    self.emailField.placeholder = @"Please enter your email address.";
    self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.emailField];
    
    NSLayoutConstraint *emailLeading = [NSLayoutConstraint constraintWithItem:self.emailField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    NSLayoutConstraint *emailTop = [NSLayoutConstraint constraintWithItem:self.emailField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.lastNameField
                                                           attribute:NSLayoutAttributeBottom
                                                          multiplier:1.0
                                                            constant:10.0];
    NSLayoutConstraint *emailTrailing = [NSLayoutConstraint constraintWithItem:self.emailField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:20.0];
    
    emailLeading.active = YES;
    emailTop.active = YES;
    emailTrailing.active = YES;
}

- (void)setupMessageLabel
{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //startdate -> change "Today"
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From: %@ - To: %@", self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle], [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    
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
                                                                constant:1.0];
    
    leading.active = YES;
    trailing.active = YES;
    centerY.active = YES;
}

- (void)saveButtonSelected:(UIBarButtonItem *)sender
{
//    Reservation *reservation = [Reservation reservationWithStartDate:self.startDate endDate:self.endDate room:self.room];
//    
//    reservation.guest = [Guest guestWithName:self.nameField.text lastName:self.lastNameField.text email:self.emailField.text];
//    
//    self.room.reservation = reservation;
//    
//    NSError *error;
//    [[NSManagedObjectContext managerContext] save:&error];
    
    Guest *guest = [Guest guestWithName:self.nameField.text lastName:self.lastNameField.text email:self.emailField.text];
    
    ReservationService *operator = [[ReservationService alloc]init];
    
    if ([operator saveReservationWithStartDate:self.startDate endDate:self.endDate room:self.room guest:guest]) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end
