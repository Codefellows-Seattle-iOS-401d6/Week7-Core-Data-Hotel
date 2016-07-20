//
//  BookViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "BookViewController.h"
#import "NSManagedObject+managedContext.h"


@interface BookViewController ()
@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *emailField;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMessageLabel];
    [self setupTextFields];
    [self setupBookVC];
}

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupBookVC {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"%@", self.room.hotel.name]];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

-(void)setupMessageLabel {
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    [messageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From: %@ - To: %@", self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle: NSDateFormatterNoStyle], [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle: NSDateFormatterNoStyle]];
    
    [self.view addSubview:messageLabel];
    
    //set constraints on messageLabel
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    leading.active = YES;
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant: -20.0];
    trailing.active = YES;
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant: 0.0];
    centerY.active = YES;
}

-(void)setupTextFields {
    // setup nameField
    self.nameField = [[UITextField alloc]init];
    self.nameField.placeholder = @"Please enter your name";
    [self.nameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview: self.nameField];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem: self.nameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:84.0];
    top.active = YES;
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem: self.nameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    leading.active = YES;
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem: self.nameField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant: -20.0];
    trailing.active = YES;
    
    [self.nameField becomeFirstResponder];
    
    // setup lastNameField
    self.lastNameField = [[UITextField alloc]init];
    self.lastNameField.placeholder = @"Please enter your last name";
    [self.lastNameField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview: self.lastNameField];
    NSLayoutConstraint *lastNameFieldTop = [NSLayoutConstraint constraintWithItem: self.lastNameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.nameField attribute:NSLayoutAttributeTop multiplier:1.0 constant:30.0];
    lastNameFieldTop.active = YES;
    
    NSLayoutConstraint *lastNameFieldLeading = [NSLayoutConstraint constraintWithItem: self.lastNameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    lastNameFieldLeading.active = YES;
    
    NSLayoutConstraint *lastNameFieldTrailing = [NSLayoutConstraint constraintWithItem: self.lastNameField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant: -20.0];
    lastNameFieldTrailing.active = YES;
    
    // setup lastNameField
    self.emailField = [[UITextField alloc]init];
    self.emailField.placeholder = @"Please enter your email";
    [self.emailField setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview: self.emailField];
    NSLayoutConstraint *emailFieldTop = [NSLayoutConstraint constraintWithItem: self.emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lastNameField attribute:NSLayoutAttributeTop multiplier:1.0 constant:30.0];
    emailFieldTop.active = YES;
    
    NSLayoutConstraint *emailFieldleading = [NSLayoutConstraint constraintWithItem: self.emailField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    emailFieldleading.active = YES;
    
    NSLayoutConstraint *emailFieldTrailing = [NSLayoutConstraint constraintWithItem: self.emailField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant: -20.0];
    emailFieldTrailing.active = YES;
}


-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    Reservation *reservation = [Reservation reservationWithStartDate: self.startDate endDate:self.endDate room: self.room];
    self.room.reservation = reservation;
    reservation.guest = [Guest guestWithName:self.nameField.text lastName:self.lastNameField.text email:self.emailField.text];
    
    NSError *error;
    [[NSManagedObject managedContext] save:&error];
    
    if (error) {
        NSLog(@"Error saving reservation.");
    } else {
        [self.navigationController popToRootViewControllerAnimated: YES];
    }
}

@end
