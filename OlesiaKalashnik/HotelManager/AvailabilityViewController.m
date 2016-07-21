//
//  AvailabilityViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/19/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "BookViewController.h"
#import "NSManagedObject+managedContext.h"
#import "ReservationService.h"

@interface AvailabilityViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)NSArray *datasource;
@property (strong, nonatomic)ReservationService *reservService;

@end

@implementation AvailabilityViewController

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Rooms"];
    self.reservService = [[ReservationService alloc]init];
    [self setupTableView];
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    //register cell class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier: @"Cell"];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeLeading relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeLeading multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTrailing relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTrailing multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTop multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeBottom multiplier: 1.0 constant:0.0];
    
    leading.active = YES;
    trailing.active = YES;
    top.active = YES;
    bottom.active = YES;
}

-(NSArray *)datasource {
    return [self.reservService getAvailableRooms:self.startDate endDate:self.endDate];
}

//UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Room *room = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat: @"Room: %i (%i beds, $%0.2f per night)", room.number.intValue, room.beds.intValue, room.rate.floatValue];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 150;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIImage *headerImage = [UIImage imageNamed:@"hotel"];
    UIImageView *headerView = [[UIImageView alloc]initWithImage:headerImage];
    headerView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150.0);
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.clipsToBounds = YES;
    
    return headerView;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Room *room = self.datasource[indexPath.row];
    BookViewController *bookVC = [[BookViewController alloc]init];
    bookVC.room = room;
    bookVC.endDate = self.endDate;
    bookVC.startDate = self.startDate;
    
    [self.navigationController pushViewController:bookVC animated:YES];
}



@end
