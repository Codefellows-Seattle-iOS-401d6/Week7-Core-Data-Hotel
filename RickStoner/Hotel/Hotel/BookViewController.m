//
//  BookViewController.m
//  Hotel
//
//  Created by Rick  on 7/19/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "BookViewController.h"
#import "NSManagedObject+NSManagedObjectContextCategory.h"

@interface BookViewController ()

@property (strong, nonatomic)UITextField *firstNameField;
@property (strong, nonatomic)UITextField *lastNameField;
@property (strong, nonatomic)UITextField *emailField;

@end

@implementation BookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupBookViewController];
    [self setupMessageLabel];
    [self setupNameField];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupBookViewController {
    [self.navigationItem setTitle:self.room.hotel.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}


- (void)saveButtonSelected:(UIBarButtonItem *)sender {
    if (self.firstNameField.text == nil || self.lastNameField.text == nil || self.emailField.text == nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Empty Fields" message:@"Please ensure all fields are filled out" preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion: nil];
        
        return;
    }
    Reservation *reservation = [Reservation reservationWithStartDate:self.startDate endDate:self.endDate room:self.room];
    
    self.room.reservation = reservation;
    reservation.guest = [Guest guestWithName:self.firstNameField.text lastName:self.lastNameField.text email:self.emailField.text];
    
    NSError* error;
    [[NSManagedObject managedContext] save:&error];
    if (error) {
        NSLog(@"Error saving reservation. Error: %@", error);
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

- (void)setupMessageLabel {
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room %i, From: %@ to %@ ", self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle], [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    
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

- (void)setupNameField {
    self.firstNameField = [[UITextField alloc]init];
    self.lastNameField = [[UITextField alloc]init];
    self.emailField = [[UITextField alloc]init];
    
    self.firstNameField.placeholder = @"Please enter your first name";
    self.lastNameField.placeholder = @"Please enter your last name";
    self.emailField.placeholder = @"Please enter email";
    
    [self.view addSubview:self.firstNameField];
    [self.view addSubview:self.lastNameField];
    [self.view addSubview:self.emailField];
    
    self.firstNameField.translatesAutoresizingMaskIntoConstraints = NO;
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = NO;
    self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *leadingFirst = [NSLayoutConstraint constraintWithItem: self.firstNameField
                                                              attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                    constant:20.0];
    
    NSLayoutConstraint *trailingFirst = [NSLayoutConstraint constraintWithItem: self.firstNameField
                                                              attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                 constant:-20.0];
    
    NSLayoutConstraint *topFirst = [NSLayoutConstraint constraintWithItem: self.firstNameField
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                            constant:84.0];
    
    NSLayoutConstraint *leadingLast = [NSLayoutConstraint constraintWithItem: self.lastNameField
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:20.0];
    
    NSLayoutConstraint *trailingLast = [NSLayoutConstraint constraintWithItem: self.lastNameField
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:-20.0];
    
    NSLayoutConstraint *topLast = [NSLayoutConstraint constraintWithItem: self.lastNameField
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:144.0];
    
    NSLayoutConstraint *leadingEmail = [NSLayoutConstraint constraintWithItem: self.emailField
                                                                    attribute:NSLayoutAttributeLeading
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self.view
                                                                    attribute:NSLayoutAttributeLeading
                                                                   multiplier:1.0
                                                                     constant:20.0];
    
    NSLayoutConstraint *trailingEmail = [NSLayoutConstraint constraintWithItem: self.emailField
                                                                     attribute:NSLayoutAttributeTrailing
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.view
                                                                     attribute:NSLayoutAttributeTrailing
                                                                    multiplier:1.0
                                                                      constant:-20.0];
    
    NSLayoutConstraint *topEmail = [NSLayoutConstraint constraintWithItem: self.emailField
                                                                attribute:NSLayoutAttributeTop
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.view
                                                                attribute:NSLayoutAttributeTop
                                                               multiplier:1.0
                                                                 constant:204.0];
    
    leadingFirst.active = YES;
    trailingFirst.active = YES;
    topFirst.active = YES;
    leadingLast.active = YES;
    trailingLast.active = YES;
    topLast.active = YES;
    leadingEmail.active = YES;
    trailingEmail.active = YES;
    topEmail.active = YES;
    
    [self.firstNameField becomeFirstResponder];
}




@end
