//
//  ViewController.m
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "ViewController.h"
#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "DateViewController.h"
#import "LookupViewController.h"
#import "AppDelegate+CoreDataStack.h"

@import CoreData;

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self setupCustomLayout];
    [self.view setBackgroundColor:[UIColor grayColor]];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewController {
    [self.navigationItem setTitle:@"ObjectManager"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSManagedObjectContext *context = [AppDelegate managedObjectContext];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName: @"Guest"];
    NSArray *guests = [context executeFetchRequest: request error: nil];
    
    NSLog(@"guests: %lu", (unsigned long)guests.count );
}

- (void) setupCustomLayout {
    
    float navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    UIButton *browseButton = [[UIButton alloc]init];
    UIButton *reserveButton = [[UIButton alloc]init];
    UIButton *searchButton = [[UIButton alloc]init];
    
    [browseButton setTitle: @"browse" forState:UIControlStateNormal];
    [reserveButton setTitle: @"reserve" forState:UIControlStateNormal];

    [searchButton setTitle: @"lookup" forState:UIControlStateNormal];
    
    [browseButton setBackgroundColor:[UIColor colorWithRed: 1.0 green: 1.0 blue: 0.76 alpha: 1.0]];
    [reserveButton setBackgroundColor:[UIColor colorWithRed: 1.0 green: 0.91 blue: 0.76 alpha: 1.0]];
    [searchButton setBackgroundColor:[UIColor colorWithRed: 0.85 green: 0.91 blue: 0.76 alpha: 1.0]];
    
    [browseButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [reserveButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    [searchButton setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [reserveButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [searchButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    
    NSLayoutConstraint *browseButtonLeading = [NSLayoutConstraint constraintWithItem:browseButton
                                                attribute:NSLayoutAttributeLeading
                                                relatedBy:NSLayoutRelationEqual toItem:self.view
                                                attribute:NSLayoutAttributeLeading
                                                multiplier:1.0 constant:0.0];
    NSLayoutConstraint *browseButtonTop = [NSLayoutConstraint constraintWithItem:browseButton
                                               attribute:NSLayoutAttributeTop
                                               relatedBy:NSLayoutRelationEqual toItem:self.view
                                               attribute:NSLayoutAttributeTop
                                              multiplier:1.0 constant:70.0];
    NSLayoutConstraint *browseButtonTrailing = [NSLayoutConstraint constraintWithItem:browseButton
                                               attribute:NSLayoutAttributeTrailing
                                               relatedBy:NSLayoutRelationEqual toItem:self.view
                                               attribute:NSLayoutAttributeTrailing
                                              multiplier:1.0 constant:0.0];
    NSLayoutConstraint *browseButtonHeight = [NSLayoutConstraint constraintWithItem:browseButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute: NSLayoutAttributeHeight multiplier:0.25 constant:1.0];

    [self.view addSubview:browseButton];
    
    browseButtonTop.active = YES;
    browseButtonLeading.active = YES;
    browseButtonTrailing.active = YES;
    browseButtonHeight.active = YES;
    
    [browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLayoutConstraint *reserveButtonLeading = [NSLayoutConstraint constraintWithItem:reserveButton
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0 constant:0.0];
    NSLayoutConstraint *reserveButtonTop = [NSLayoutConstraint constraintWithItem:reserveButton
                                                                       attribute:NSLayoutAttributeTop
                                                                       relatedBy:NSLayoutRelationEqual toItem:browseButton
                                                                       attribute:NSLayoutAttributeBottom
                                                                      multiplier:1.0 constant:6.0];
    NSLayoutConstraint *reserveButtonTrailing = [NSLayoutConstraint constraintWithItem:reserveButton
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1.0 constant:0.0];
    NSLayoutConstraint *reserveButtonHeight = [NSLayoutConstraint constraintWithItem:reserveButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute: NSLayoutAttributeHeight multiplier:0.25 constant:0.0];
    
    [self.view addSubview:reserveButton];
    
    reserveButtonTop.active = YES;
    reserveButtonLeading.active = YES;
    reserveButtonTrailing.active = YES;
    reserveButtonHeight.active = YES;
    
    [reserveButton addTarget:self action:@selector(reserveButtonSelected:) forControlEvents:UIControlEventTouchUpInside];

    NSLayoutConstraint *searchButtonLeading = [NSLayoutConstraint constraintWithItem:searchButton
                                                                            attribute:NSLayoutAttributeLeading
                                                                            relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                            attribute:NSLayoutAttributeLeading
                                                                           multiplier:1.0 constant:0.0];
    NSLayoutConstraint *searchButtonTop = [NSLayoutConstraint constraintWithItem:searchButton
                                                                        attribute:NSLayoutAttributeTop
                                                                        relatedBy:NSLayoutRelationEqual toItem:reserveButton
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0 constant:6.0];
    NSLayoutConstraint *searchButtonTrailing = [NSLayoutConstraint constraintWithItem:searchButton
                                                                             attribute:NSLayoutAttributeTrailing
                                                                             relatedBy:NSLayoutRelationEqual toItem:self.view
                                                                             attribute:NSLayoutAttributeTrailing
                                                                            multiplier:1.0 constant:0.0];
    NSLayoutConstraint *searchButtonHeight = [NSLayoutConstraint constraintWithItem:searchButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute: NSLayoutAttributeHeight multiplier:0.25 constant:0.0];
    
    [self.view addSubview:searchButton];
    
    searchButtonTop.active = YES;
    searchButtonLeading.active = YES;
    searchButtonTrailing.active = YES;
    searchButtonHeight.active = YES;
    
    [searchButton addTarget:self action:@selector(searchButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    

}

-(void) browseButtonSelected: (UIButton *)sender{
    NSLog(@"Browse");
    
    [self.navigationController pushViewController:[[HotelsViewController alloc]init] animated:YES];
    
}

-(void) reserveButtonSelected: (UIButton *)sender{
    
    [self.navigationController pushViewController:[DateViewController new] animated:YES];
    
}
-(void) searchButtonSelected: (UIButton *)sender{
    [self.navigationController pushViewController:[LookupViewController new] animated:YES];

}

@end
