//
//  ViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/18/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "HotelsViewController.h"
#import "DateViewController.h"
#import "NSManagedObject+managedContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
    [self setupCustomLayout];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    NSError *error;
    NSArray *results = [[NSManagedObject managedContext] executeFetchRequest:request error:&error];
    if (!error) {
        NSLog(@"Guest count: %li", results.count);
    } else {
        NSLog(@"Error occured when fetching guests");
    }
}

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupVC {
    [self.navigationItem setTitle:@"HotelManager"];
}


-(void)setupCustomLayout {
    float navBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    UIButton *browseButton = [[UIButton alloc]init];
    UIButton *bookButton =  [[UIButton alloc]init];
    UIButton *lookupButton = [[UIButton alloc]init];
    
    [browseButton setTitle:@"Browse" forState: UIControlStateNormal];
    [bookButton setTitle:@"Book" forState: UIControlStateNormal];
    [lookupButton setTitle:@"Lookup" forState: UIControlStateNormal];
    
    [browseButton setBackgroundColor:[UIColor colorWithRed: 1.0 green: 1.0 blue: 0.75 alpha: 0.5]];
    [bookButton setBackgroundColor:[UIColor colorWithRed: 0.3 green: 0.7 blue: 0.8 alpha: 0.5]];
    [lookupButton setBackgroundColor:[UIColor colorWithRed: 0.3 green: 0.8 blue: 0.7 alpha: 0.5]];
    
    [browseButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [bookButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    [lookupButton setTitleColor:[UIColor blackColor] forState: UIControlStateNormal];
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lookupButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:browseButton];
    [self.view addSubview:bookButton];
    [self.view addSubview:lookupButton];
    
    //constraints
    NSLayoutConstraint *browseButtonLeading = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    browseButtonLeading.active = YES;
    
    NSLayoutConstraint *browseButtonTrailing = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    browseButtonTrailing.active = YES;
    
    
    NSLayoutConstraint *browseButtonTop = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier: 1.0 constant:64.0];
    browseButtonTop.active = YES;
    
    
    NSLayoutConstraint *bookButtonLeading = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    bookButtonLeading.active = YES;
    
    NSLayoutConstraint *bookButtonTrailing = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    bookButtonTrailing.active = YES;
    
    NSLayoutConstraint *bookButtonCenterY = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:navBarHeight/1.4];
    bookButtonCenterY.active = YES;
    
    NSLayoutConstraint *lookupButtonLeading = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    lookupButtonLeading.active = YES;
    
    NSLayoutConstraint *lookupButtonTrailing = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    lookupButtonTrailing.active = YES;
    
    NSLayoutConstraint *lookupButtonBottom = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    lookupButtonBottom.active = YES;
    
    NSLayoutConstraint *browseButtonHeight = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    browseButtonHeight.active = YES;
    
    NSLayoutConstraint *bookButtonHeight = [NSLayoutConstraint constraintWithItem:bookButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:0.3 constant:0.0];
    bookButtonHeight.active = YES;
    
    NSLayoutConstraint *lookupButtonHeight = [NSLayoutConstraint constraintWithItem:lookupButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:bookButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:-3.0];
    lookupButtonHeight.active = YES;
    
    //setup actions
    [browseButton addTarget: self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget: self action:@selector(bookButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [lookupButton addTarget: self action:@selector(lookupButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) browseButtonSelected: (UIButton *)selector {
    NSLog(@"Browse");
    [self.navigationController pushViewController:[[HotelsViewController alloc] init] animated:YES];
}

-(void)bookButtonSelected: (UIButton *)selector {
    [self.navigationController pushViewController:[DateViewController new] animated:YES];
}

-(void)lookupButtonSelected: (UIButton *)selector {
    NSLog(@"Lookup");
}




@end
