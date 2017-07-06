//
//  BookViewController.m
//  Manager
//
//  Created by David Livingstone on 7/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "BookViewController.h"
#import "NSObject+NSManagedObjectContext.h"

@interface BookViewController ()

@property(strong, nonatomic) UITextField *firstNameField;
@property(strong, nonatomic) UITextField *lastNameField;
@property(strong, nonatomic) UITextField *emailField;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupBookViewController];
    [self setupNameFields];
}


-(void)setupBookViewController{
    [self.navigationItem setTitle:self.room.hotel.name];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}


-(void)setupNameFields {
    
    self.firstNameField = [[UITextField alloc]init];
    self.lastNameField = [[UITextField alloc]init];
    self.emailField = [[UITextField alloc]init];

    self.firstNameField.placeholder = @"First Name";
    self.lastNameField.placeholder = @"Last Name";
    self.emailField.placeholder = @"Email";
    
    self.firstNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.lastNameField.borderStyle = UITextBorderStyleRoundedRect;
    self.emailField.borderStyle = UITextBorderStyleRoundedRect;
    
    self.firstNameField.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = NO;
    self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 25;
    
    [stackView addArrangedSubview:_firstNameField];
    [stackView addArrangedSubview:_lastNameField];
    [stackView addArrangedSubview:_emailField];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:stackView];
    
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;
    
    [self.firstNameField becomeFirstResponder];
    [self.lastNameField becomeFirstResponder];
    [self.emailField becomeFirstResponder];
}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    Reservation *reservation = [Reservation reservationWithStartDate:[NSDate date] endDate:self.end room:self.room];
    
    self.room.reservation = reservation;
    
    reservation.guest = [Guest guestWithEmail:self.emailField.text first:self.firstNameField.text last:self.lastNameField.text];
    
    NSError *error;
    [[NSObject managerContext] save:&error];
    
    if (error) {
        NSLog(@"Save error: %@", error);
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

@end