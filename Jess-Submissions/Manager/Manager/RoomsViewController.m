//
//  RoomsViewController.m
//  Manager
//
//  Created by Jess Malesh on 7/18/16.
//  Copyright © 2016 Jess Malesh. All rights reserved.
//

#import "RoomsViewController.h"
#import "Hotel.h"

@interface RoomsViewController ()

@end

@implementation RoomsViewController

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupViewControl];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)setupViewControl
{
    [self.navigationItem setTitle:@"Rooms"];
}

- (void)setupCustomLayout
{
    
}

@end
