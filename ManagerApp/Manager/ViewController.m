//
//  ViewController.m
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "ViewController.h"
#import "HotelsViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(void)loadView {
    [super loadView];
    
    [self setupCustomLayout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupViewController];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupViewController {
    [self.navigationItem setTitle:@"🏨 💁"];
}

- (void)setupCustomLayout {
    
    // create buttons
    
    UIButton *browseButton = [[UIButton alloc]init];
    UIButton *bookButton = [[UIButton alloc]init];
    UIButton *lookupButton = [[UIButton alloc]init];

    
    // set button titles
    
    [browseButton setTitle:@"Browse Hotels" forState:UIControlStateNormal];
    [bookButton setTitle:@"Book A Room" forState:UIControlStateNormal];
    [lookupButton setTitle:@"Lookup A Reservation" forState:UIControlStateNormal];
    
    // set button background colors
    
    [browseButton setBackgroundColor:[UIColor colorWithHue:0.554 saturation:0.668 brightness:0.957 alpha:1]];
    [bookButton setBackgroundColor:[UIColor colorWithHue:0.221 saturation:0.703 brightness:0.792 alpha:1]];
    [lookupButton setBackgroundColor:[UIColor colorWithHue:0.112 saturation:0.793 brightness:0.965 alpha:1]];
    
    // set button title colors
    
    [browseButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookupButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // set button title size
    
    [browseButton.titleLabel setFont: [browseButton.titleLabel.font fontWithSize: 24.0]];
    [bookButton.titleLabel setFont: [bookButton.titleLabel.font fontWithSize: 24.0]];
    [lookupButton.titleLabel setFont: [lookupButton.titleLabel.font fontWithSize: 24.0]];
    
    // set button autoresizing
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lookupButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // set button constraints
    
    NSLayoutConstraint *browseButtonLeading = [NSLayoutConstraint constraintWithItem:browseButton
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *browseButtonTop = [NSLayoutConstraint constraintWithItem:browseButton
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeTop
                                                                      multiplier:1.0
                                                                        constant:64.0];
    
    NSLayoutConstraint *browseButtonTrailing = [NSLayoutConstraint constraintWithItem:browseButton
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1.0
                                                                             constant:0.0];
    
    NSLayoutConstraint *bookButtonLeading = [NSLayoutConstraint constraintWithItem:bookButton
                                                                         attribute:NSLayoutAttributeLeading
                                                                         relatedBy:NSLayoutRelationEqual
                                                                            toItem:self.view
                                                                         attribute:NSLayoutAttributeLeading
                                                                        multiplier:1.0
                                                                          constant:0.0];
    
    NSLayoutConstraint *bookButtonCenterY= [NSLayoutConstraint constraintWithItem:bookButton
                                                                        attribute:NSLayoutAttributeCenterY
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeCenterY
                                                                       multiplier:1.0
                                                                         constant:0.0];
    
    NSLayoutConstraint *bookButtonTrailing = [NSLayoutConstraint constraintWithItem:bookButton
                                                                          attribute:NSLayoutAttributeTrailing
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeTrailing
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    NSLayoutConstraint *lookupButtonLeading = [NSLayoutConstraint constraintWithItem:lookupButton
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0.0];
    
    NSLayoutConstraint *lookupButtonBottom = [NSLayoutConstraint constraintWithItem:lookupButton
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    NSLayoutConstraint *lookupButtonTrailing = [NSLayoutConstraint constraintWithItem:lookupButton
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1.0
                                                                             constant:0.0];
    
    NSLayoutConstraint *bookButtonHeight = [NSLayoutConstraint constraintWithItem:bookButton
                                                                        attribute:NSLayoutAttributeHeight
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.view
                                                                        attribute:NSLayoutAttributeHeight
                                                                       multiplier:0.3
                                                                         constant:0.0];
    
    NSLayoutConstraint *browseButtonHeight = [NSLayoutConstraint constraintWithItem:browseButton
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:bookButton
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    NSLayoutConstraint *lookupButtonHeight = [NSLayoutConstraint constraintWithItem:lookupButton
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:bookButton
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    // add buttons

    [self.view addSubview:browseButton];
    [self.view addSubview:bookButton];
    [self.view addSubview:lookupButton];
    
    // activate constraints
    
    browseButtonLeading.active = YES;
    browseButtonTop.active = YES;
    browseButtonTrailing.active = YES;
    
    bookButtonLeading.active = YES;
    bookButtonCenterY.active = YES;
    bookButtonTrailing.active = YES;
    
    lookupButtonLeading.active = YES;
    lookupButtonBottom.active = YES;
    lookupButtonTrailing.active = YES;
    
    bookButtonHeight.active = YES;
    browseButtonHeight.active = YES;
    lookupButtonHeight.active = YES;
    
    // set up actions
    
    [browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [lookupButton addTarget:self action:@selector(lookupButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

// set up button handlers

- (void)browseButtonSelected:(UIButton *)sender
{
    [self.navigationController pushViewController:[[HotelsViewController alloc]init] animated:YES];
}

- (void)bookButtonSelected:(UIButton *)sender
{
    NSLog(@"book");
}

- (void)lookupButtonSelected:(UIButton *)sender
{
    NSLog(@"lookup");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
