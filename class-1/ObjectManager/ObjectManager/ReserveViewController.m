//
//  ReserveViewController.m
//  ObjectManager
//
//  Created by Derek Graham on 7/19/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "ReserveViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "Guest.h"
#import "Reservation.h"
#import "ReservationService.h"

@interface ReserveViewController ()

@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *paymentField;
@property (strong, nonatomic) UITextField *notesField;


@end

@implementation ReserveViewController

- (void) loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupReserveViewController];
    [self setupMessageLabel];
    [self setupNameFields];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupReserveViewController {
    [self.navigationItem setTitle: self.room.hotel.name];
    
    [self.navigationItem setRightBarButtonItem: [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemSave target: self action:@selector(saveButtonSelected:)] ];
    
}

- (void) setupNameFields{
    self.firstNameField = [[UITextField alloc] init];
    
    self.firstNameField.placeholder = @"First name:";
    self.firstNameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.firstNameField];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.firstNameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];

    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.firstNameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:84.0];

    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.firstNameField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
  
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    
    [self.firstNameField becomeFirstResponder];
    
    self.lastNameField = [[UITextField alloc] init];
    
    self.lastNameField.placeholder = @"Last name:";
    self.lastNameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.lastNameField];
    
    NSLayoutConstraint *leadingLastName = [NSLayoutConstraint constraintWithItem:self.lastNameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    
    NSLayoutConstraint *topLastName = [NSLayoutConstraint constraintWithItem:self.lastNameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.firstNameField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16.0];
    
    
    NSLayoutConstraint *trailingLastName = [NSLayoutConstraint constraintWithItem:self.lastNameField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    leadingLastName.active = YES;
    topLastName.active = YES;
    trailingLastName.active = YES;

    self.emailField = [[UITextField alloc] init];
    
    self.emailField.placeholder = @"Email address:";
    self.emailField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.emailField];
    
    NSLayoutConstraint *leadingEmail = [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    
    NSLayoutConstraint *topEmail = [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.lastNameField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16.0];
    
    
    NSLayoutConstraint *trailingEmail = [NSLayoutConstraint constraintWithItem:self.emailField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    leadingEmail.active = YES;
    topEmail.active = YES;
    trailingEmail.active = YES;

    self.paymentField = [[UITextField alloc] init];
    
    self.paymentField.placeholder = @"Payment";
    self.paymentField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.paymentField];
    
    NSLayoutConstraint *leadingPayment = [NSLayoutConstraint constraintWithItem:self.paymentField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    
    NSLayoutConstraint *topPayment = [NSLayoutConstraint constraintWithItem:self.paymentField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.emailField attribute:NSLayoutAttributeBottom multiplier:1.0 constant:16.0];
    
    
    NSLayoutConstraint *trailingPayment = [NSLayoutConstraint constraintWithItem:self.paymentField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    leadingPayment.active = YES;
    topPayment.active = YES;
    trailingPayment.active = YES;

}


-(void) setupMessageLabel{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From:(STARTDATE) - to:%@", self.room.hotel.name, self.room.roomNumber.intValue, [NSDateFormatter localizedStringFromDate: self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    
    [self.view addSubview:messageLabel];
    
//    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:72.0];

    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];

    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0];
    
    
//    top.active = YES;
    leading.active = YES;
    trailing.active = YES;
    centerY.active = YES;
    
    
}


- (void) saveButtonSelected:(UIBarButtonItem *)sender{
    ReservationService *operator = [[ReservationService alloc]init];
    
    Guest *guest = [Guest guestWithNameAndEmail:self.firstNameField.text lastName:self.lastNameField.text email:self.emailField.text payment: self.paymentField.text notes: self.notesField.text];
    
    BOOL success = [operator bookRoomStarting:self.startDate endDate:self.endDate room:self.room guest:guest];
    if(success)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    
//    Reservation *reservation = [Reservation reservationWithStartDate:[NSDate date] endDate:self.endDate room:self.room];
    
//    self.room.reservation = reservation;
//    
//    reservation.guest = [Guest guestWithNameAndEmail:self.firstNameField.text lastName:self.lastNameField.text email:self.emailField.text payment: self.paymentField.text notes: self.notesField.text];
    
//    NSError *error;
//    [[NSObject managerContext] save: &error];
//    
//    
//    if (error) {
//        NSLog(@"Save error: %@",error);
//    }
//    
//    else {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
