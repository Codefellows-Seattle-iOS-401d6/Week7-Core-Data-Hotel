//
//  ViewController.m
//  Hotel
//
//  Created by Rick  on 7/18/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "ViewController.h"
#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "DateViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupCustomLayout];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    AppDelegate *delegate = [[UIApplication sharedApplication]delegate];
    
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guest"];
    NSError *error;
    
    NSArray *guest = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"Error with Guest fetch request. Error: %@", error);
    }
    
    NSLog(@"Guestcount: %li", guest.count);
    
}

- (void)setupViewController {
    [self.navigationItem setTitle:@"Book Hotel"];
}

- (void)setupCustomLayout {
    float navigationBarHeight = CGRectGetHeight(self.navigationController.navigationBar.frame);
    
    UIButton *browseButton = [[UIButton alloc]init];
    UIButton *bookButton = [[UIButton alloc]init];
    UIButton *lookUpButton = [[UIButton alloc]init];
    
    [browseButton setTitle:@"Browse" forState:UIControlStateNormal];
    [bookButton setTitle:@"Book" forState:UIControlStateNormal];
    [lookUpButton setTitle:@"Look Up" forState:UIControlStateNormal];
    
    [browseButton setBackgroundColor:[UIColor colorWithRed:0.5 green:.91 blue:.76 alpha:1.0]];
    [bookButton setBackgroundColor:[UIColor colorWithRed:0.2 green:0.91 blue:0.76 alpha:1.0]];
    [lookUpButton setBackgroundColor:[UIColor colorWithRed:0.2 green:.76 blue:.91 alpha:1.0]];
    
    [browseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bookButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [lookUpButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [browseButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [bookButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [lookUpButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    
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
                                                                          multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *bookButtonTop = [NSLayoutConstraint constraintWithItem:bookButton
                                                                       attribute:NSLayoutAttributeCenterY
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.view
                                                                       attribute:NSLayoutAttributeCenterY
                                                                      multiplier:1.0
                                                                        constant:navigationBarHeight/1.4]; //tried others but couldn't improve on this hackish method.
    
    NSLayoutConstraint *bookButtonTrailing = [NSLayoutConstraint constraintWithItem:bookButton
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1.0
                                                                             constant:0.0];
    
    NSLayoutConstraint *lookUpButtonLeading = [NSLayoutConstraint constraintWithItem:lookUpButton
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.view
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0.0];
    
    NSLayoutConstraint *lookUpButtonBottom = [NSLayoutConstraint constraintWithItem:lookUpButton
                                                                          attribute:NSLayoutAttributeBottom
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeBottom
                                                                         multiplier:1.0
                                                                           constant:0.0];
    
    NSLayoutConstraint *lookUpButtonTrailing = [NSLayoutConstraint constraintWithItem:lookUpButton
                                                                            attribute:NSLayoutAttributeTrailing
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:self.view
                                                                            attribute:NSLayoutAttributeTrailing
                                                                           multiplier:1.0
                                                                             constant:0.0];
    
    [self.view addSubview:browseButton];
    [self.view addSubview:bookButton];
    [self.view addSubview:lookUpButton];
    
    //ugh, activate constaints, there has to be a better way.... oh right, it's called storyboard
    
    browseButtonTop.active = YES;
    browseButtonLeading.active = YES;
    browseButtonTrailing.active = YES;
    
    bookButtonTop.active = YES;
    bookButtonLeading.active = YES;
    bookButtonTrailing.active = YES;
    
    lookUpButtonBottom.active = YES;
    lookUpButtonLeading.active = YES;
    lookUpButtonTrailing.active = YES;
    
    
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
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:0.3
                                                                           constant:0.0];
    
    NSLayoutConstraint *lookUpButtonHeight = [NSLayoutConstraint constraintWithItem:lookUpButton
                                                                          attribute:NSLayoutAttributeHeight
                                                                          relatedBy:NSLayoutRelationEqual
                                                                             toItem:self.view
                                                                          attribute:NSLayoutAttributeHeight
                                                                         multiplier:0.3
                                                                           constant:0.0];
    
    bookButtonHeight.active = YES;
    browseButtonHeight.active = YES;
    lookUpButtonHeight.active = YES;
    
    [browseButton addTarget:self action:@selector(browseButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [bookButton addTarget:self action:@selector(bookButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
    [lookUpButton addTarget:self action:@selector(lookUpButtonSelected:) forControlEvents:UIControlEventTouchUpInside];
}

// Button clicked methods

- (void)browseButtonSelected:(UIButton *)sender {
    [self.navigationController pushViewController:[[HotelsViewController alloc]init] animated:YES];
}

- (void)bookButtonSelected:(UIButton *)sender {
    [self.navigationController pushViewController:[[DateViewController alloc]init] animated:YES];
}

- (void)lookUpButtonSelected:(UIButton *)sender {
    NSLog(@"Look Up.. as in look up and click Browse if you want anything to happen");
}

@end
