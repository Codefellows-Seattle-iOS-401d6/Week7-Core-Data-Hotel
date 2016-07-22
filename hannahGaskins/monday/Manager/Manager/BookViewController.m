//
//  BookViewController.m
//  Manager
//
//  Created by hannah gaskins on 7/19/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//


#import "BookViewController.h"

#import "NSObject+NSManagedObject.h"
#import "ReservationService.h"
#import "Flurry.h"

@interface BookViewController ()

@property(strong, nonatomic) UITextField *nameField;
@property(strong, nonatomic) UITextField *lastNameField;
@property(strong, nonatomic) UITextField *emailField;
@property(strong, nonatomic) UITextField *phoneField;


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
                                                                 constant:-20.0];

    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    
    self.lastNameField = [[UITextField alloc]init];
    self.lastNameField.placeholder = @"Please enter your last name.";
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.lastNameField];
    
    NSLayoutConstraint *leadingLN = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    NSLayoutConstraint *topLN = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0
                                                            constant:109.2];
    
    NSLayoutConstraint *trailingLN = [NSLayoutConstraint constraintWithItem:self.lastNameField
                                                                attribute:NSLayoutAttributeTrailing
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTrailing
                                                               multiplier:1.0
                                                                 constant:-20.0];
    
    leadingLN.active = YES;
    topLN.active = YES;
    trailingLN.active = YES;
    
    self.emailField = [[UITextField alloc]init];
    self.emailField.placeholder = @"Please enter your email 📧.";
    self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.emailField];
    
    NSLayoutConstraint *leadingEM = [NSLayoutConstraint constraintWithItem:self.emailField
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:20.0];
    
    NSLayoutConstraint *topEM = [NSLayoutConstraint constraintWithItem:self.emailField
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:134.4];

    NSLayoutConstraint *trailingEM = [NSLayoutConstraint constraintWithItem:self.emailField
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-20.0];
    
    leadingEM.active = YES;
    topEM.active = YES;
    trailingEM.active = YES;
    
    
    self.phoneField = [[UITextField alloc]init];
    self.phoneField.placeholder = @"Please enter your phone.";
    self.phoneField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.phoneField];
    
    NSLayoutConstraint *leadingPhone = [NSLayoutConstraint constraintWithItem:self.phoneField
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.view
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:20.0];
    NSLayoutConstraint *topPhone = [NSLayoutConstraint constraintWithItem:self.phoneField
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1.0
                                                              constant:159.2];
    
    NSLayoutConstraint *trailingPhone = [NSLayoutConstraint constraintWithItem:self.phoneField
                                                                  attribute:NSLayoutAttributeTrailing
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.view
                                                                  attribute:NSLayoutAttributeTrailing
                                                                 multiplier:1.0
                                                                   constant:-20.0];
    
    leadingPhone.active = YES;
    topPhone.active = YES;
    trailingPhone.active = YES;
    
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
    
    [Flurry logEvent:@"saveButtonSelected"];

    
    __weak typeof(self) weakSelf = self; // for retain cycle prevention
   
    [ReservationService bookRoomMethod:self.endDate
                             startDate:self.startDate
                                 email:self.room
                        firstNameField:self.nameField
                         lastNameField:self.lastNameField
                            emailField:self.emailField
                            phoneField:self.phoneField
                            completion:^{
                                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                            }];
    
//    [ReservationService bookRoomMethod:self.endDate
//                             startDate:self.startDate
//                                 email:self.room
//                             nameField:self.nameField
//                         lastNameField:self.lastNameField
//                            emailField:self.emailField
//                            phoneField:self.phoneField
//                            completion: ^ {
//                                
//                                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
//                                
//                            }];
}


@end
