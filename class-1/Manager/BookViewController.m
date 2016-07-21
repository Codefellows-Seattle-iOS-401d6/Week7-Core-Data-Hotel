//
//  BookViewController.m
//  Manager
//
//  Created by Sean Champagne on 7/19/16.
//  Copyright © 2016 Sean Champagne. All rights reserved.
//

#import "BookViewController.h"
#import "NSObject+NSManagedObjectContext.h"

@interface BookViewController ()

@property (strong, nonatomic) UITextField *nameField;

@end

@implementation BookViewController

- (void)loadView{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupBookViewController];
    [self setupMessageLabel];
    [self setupNameField];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupBookViewController
{
    [self.navigationItem setTitle:self.room.hotel.name];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonSelected:)]];
}

-(void)setupNameField
{
    self.nameField = [[UITextField alloc]init];
    
    self.nameField.placeholder = @"'ello!  Please enter your name.";
    self.nameField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.nameField];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:84.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.nameField attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
}

-(void) setupMessageLabel
{
    UILabel *messageLabel = [[UILabel alloc]init];
    
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.numberOfLines = 0;
    
    messageLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    messageLabel.text = [NSString stringWithFormat:@"Reservation at %@, Room: %i, From:%@ - To:%@", self.room.hotel.name, self.room.number.intValue, [NSDateFormatter localizedStringFromDate:self.startDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle], [NSDateFormatter localizedStringFromDate:self.endDate dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle]];
    
    [self.view addSubview:messageLabel];
    
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-20.0];
    
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:messageLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    

    leading.active = YES;
    trailing.active = YES;
    centerY.active = YES;
    
    }

-(void) saveButtonSelected:(UIBarButtonItem *)sender
{
    Reservation *reservation = [Reservation reservationWithStartDate:self.startDate endDate:self.endDate room:self.room];
    
    self.room.reservation = reservation;
    reservation.guest = [Guest guestWithName:self.nameField.text];
    
    NSError *error;
    [[NSObject managerContext] save:&error];
    
    if (error)
    {
        NSLog(@"Save error: %@!", error);
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    }

@end
