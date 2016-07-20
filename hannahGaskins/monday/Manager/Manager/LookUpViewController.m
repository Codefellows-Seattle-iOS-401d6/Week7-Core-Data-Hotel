//
//  LookUpViewController.m
//  Manager
//
//  Created by hannah gaskins on 7/20/16.
//  Copyright © 2016 hannah gaskins. All rights reserved.
//

#import "LookUpViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "Hotel.h"
#import "NSObject+NSManagedObject.h"


@interface LookUpViewController ()

@property(strong, nonatomic) NSArray *datasource;
@property(strong, nonatomic) UITableView *tableView;

@end

@implementation LookUpViewController ()<UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

-(void)loadView
{
    [super loadView];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Search"];
    [self setupTableView];
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeLeading
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeLeading
                                                              multiplier:1.0
                                                                constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeTop
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTop
                                                              multiplier:1.0
                                                                constant:0.0];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:0.0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.view
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:0.0];
    
    leading.active = YES;
    top.active = YES;
    trailing.active = YES;
    bottom.active = YES;
}


- (void)setDatasource:(NSArray *)datasource
{
    _datasource = datasource;
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Reservation *reservation = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Hotel: %@", reservation.guest.lastName, reservation.room.hotel.name];
    
    return cell;
}

// tableviewDelegate

-(CGFloat)tableViewL(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 44.0)];
    
    searchBar.delegate = self;
    return searchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchText = searchBar.text;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
    request.predicate = [NSPredicate predicateWithFormat:@"guest.name == %@", searchText];
    
    NSError *error;
    NSArray *results = [[NSObject managerContext] executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    } else {
        self.datasource = results;
    }
}
@end
