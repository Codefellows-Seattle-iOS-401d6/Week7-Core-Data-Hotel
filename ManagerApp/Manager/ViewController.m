//
//  ViewController.m
//  Manager
//
//  Created by David Livingstone on 7/18/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "ViewController.h"
#import "HotelsViewController.h"
#import "DatePickerViewController.h"

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
    
    // stack view

    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionEqualSpacing;
    stackView.alignment = UIStackViewAlignmentCenter;
    stackView.spacing = 25;
    
    [stackView addArrangedSubview:browseButton];
    [stackView addArrangedSubview:bookButton];
    [stackView addArrangedSubview:lookupButton];
    
    stackView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:stackView];
    
    [stackView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = true;
    [stackView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = true;

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
    [self.navigationController pushViewController:[[DatePickerViewController alloc]init] animated:YES];
}

- (void)lookupButtonSelected:(UIButton *)sender
{
    NSLog(@"lookup");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
