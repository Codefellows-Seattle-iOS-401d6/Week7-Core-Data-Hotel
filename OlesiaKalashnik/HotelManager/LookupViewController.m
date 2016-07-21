//
//  LookupViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/20/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "LookupViewController.h"
#import "NSManagedObject+ManagedContext.h"
#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "Hotel.h"
#import "ReservationService.h"

@interface LookupViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic)ReservationService *reservService;

@end

@implementation LookupViewController

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Search"];
    self.reservService = [[ReservationService alloc]init];
    [self setupTableView];
}

-(void)setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"lookupCell"];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeLeading relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeLeading multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTrailing relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTrailing multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute:NSLayoutAttributeTop multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeBottom multiplier: 1.0 constant:0.0];
    
    leading.active = YES;
    trailing.active = YES;
    top.active = YES;
    bottom.active = YES;
}

-(void)setDatasource:(NSArray *)datasource {
    _datasource = datasource;
    [self.tableView reloadData];
}

#pragma - TableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datasource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"lookupCell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"lookupCell"];
    }
    Reservation *reservation = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, hotel: %@", reservation.guest.firstName, reservation.room.hotel.name];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, 44.0)];
    searchBar.delegate = self;
    
    return searchBar;
}

#pragma - UISearchBarDelegate
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.datasource = [self.reservService searchForReservations:searchBar.text];
}


@end