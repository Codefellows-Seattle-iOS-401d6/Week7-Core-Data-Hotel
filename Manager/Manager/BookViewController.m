//
//  BookViewController.m
//  Manager
//
//  Created by Erin Roby on 7/19/16.
//  Copyright © 2016 Erin Roby. All rights reserved.
//

#import "BookViewController.h"
#import "NSObject+NSManagedObjectContext.h"

@interface BookViewController ()

@property (strong, nonatomic) UITextField *nameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *emailField;

@end

@implementation BookViewController

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBookViewController];
    [self setupMessageLabel];
    [self setupNameField];
}

- (void)setupBookViewController {
    [self.navigationItem setTitle:self.room.hotel.name];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

-(void)setupMessageLabel {
    UILabel *messageLabel = [[UILabel alloc]init];
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From: Today - To: %@", self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    
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
}

-(void)setupNameField {
    self.nameField = [[UITextField alloc]init];
    self.nameField.placeholder = @"first name";
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.nameField];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.nameField
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:20.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.nameField
                                                           attribute:NSLayoutAttributeTop
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeTop
                                                          multiplier:1.0 constant:84.0];
    
    
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
    self.lastNameField.placeholder = @"last name";
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
    self.emailField.placeholder = @"email";
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
}

-(void)saveButtonSelected:(UIBarButtonItem *)sender {
    Reservation *reservation = [Reservation reservationWithStartDate:self.startDate endDate:self.endDate room:self.room];
    self.room.reservation = reservation;
    
    NSError *error;
    [[NSObject managerContext] save:&error];
    
    if (error) {
        NSLog(@"Error saving: %@", error);
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
