//
//  RoomsViewController.m
//  Manager
//
//  Created by David Livingstone on 7/19/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

#import "RoomsViewController.h"
#import "AppDelegate.h"
#import "Room.h"
#import "Hotel.h"

@interface RoomsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupTableView];
    [self.navigationItem setTitle:@"Rooms"];
    
    for (Room *room in self.hotel.rooms) {
        NSLog(@"Number %@, beds: %@, rate: %@", room.number, room.beds, room.rate);
    }
}


- (void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem: self.tableView
                                                               attribute: NSLayoutAttributeLeading
                                                               relatedBy: NSLayoutRelationEqual
                                                                toItem: self.view
                                                               attribute: NSLayoutAttributeLeading
                                                              multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem: self.tableView
                                                            attribute: NSLayoutAttributeTrailing
                                                                relatedBy: NSLayoutRelationEqual toItem: self.view
                                                                attribute: NSLayoutAttributeTrailing multiplier: 1.0
                                                                 constant:0.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem: self.tableView
                                                           attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view
                                                                attribute:NSLayoutAttributeTop
                                                          multiplier: 1.0
                                                            constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem: self.tableView
                                                              attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.view
                                                              attribute: NSLayoutAttributeBottom multiplier: 1.0
                                                               constant:0.0];
    
    leading.active = YES;
    trailing.active = YES;
    top.active = YES;
    bottom.active = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.hotel.rooms.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RoomCell"];
    }
    
    Room *room = (Room *)[self.hotel.rooms allObjects][indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Number %@, beds: %@, rate: %@", room.number, room.beds, room.rate];
    NSLog(@"foo");
    
    return cell;
}
@end
