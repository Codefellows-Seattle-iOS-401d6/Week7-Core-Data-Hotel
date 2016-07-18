//
//  ViewController.m
//  Hotel
//
//  Created by Rick  on 7/18/16.
//  Copyright © 2016 Rick . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewController {
    [self.navigationItem setTitle:@"Hotel Managment"];
}

@end
