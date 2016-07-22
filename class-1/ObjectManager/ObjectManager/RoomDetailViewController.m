//
//  RoomDetailViewController.m
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//
#import "AppDelegate.h"
#import "RoomDetailViewController.h"
#import "Flurry.h"

@interface RoomDetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation RoomDetailViewController
- (NSArray *)datasource
{
    if (!_datasource) {
        _datasource = [NSArray  arrayWithObjects:self.room, nil ];
    }
    
    return _datasource;
}

-(void) loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor greenColor]];
}

-(void) viewDidLoad {
    [super viewDidLoad];
    [Flurry logEvent:@"ViewedRoomDetail"];

//    NSLog(@"%@)", self.room);
    [self setupTableView];
}

-(void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void) setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview: self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:20.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:20.0];
    
    leading.active = YES;
    trailing.active = YES;
    top.active = YES;
    bottom.active = YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Room: %@ \nBeds: %@ \nRate: $%.2lf \nReservation:%@", room.roomNumber,room.beds, room.rate.doubleValue, room.reservation];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;

    
    return cell;
}

#pragma mark delegate methods
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage *headerImage = [UIImage imageNamed:@"room"];
    UIImageView *headerView = [[UIImageView alloc]initWithImage: headerImage];
    
    headerView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150.0);
    
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    
    headerView.clipsToBounds = YES;
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Room *room = self.datasource[indexPath.row];

    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSString *str = [NSString stringWithFormat:@"Room: %@ \nBeds: %@ \nRate: $%.2lf \nReservation:%@", room.roomNumber,room.beds, room.rate.doubleValue, room.reservation];
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:cell.textLabel.font.pointSize
]};
    // NSString class method: boundingRectWithSize:options:attributes:context is
    // available only on ios7.0 sdk.
//    CGRect rect = [str boundingRectWithSize:CGSizeMake(self.tableView.bounds.size.width, CGFLOAT_MAX)
//                                              options:NSStringDrawingUsesLineFragmentOrigin
//                                           attributes:attributes
//                                              context:nil];
    CGSize size = [str sizeWithAttributes:attributes ];
//    CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    NSLog(@"%f",size.height);
    return size.height + 10;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    Room *room = self.datasource[indexPath.row];
//    RoomDetailViewController *roomDetailViewController = [[RoomDetailViewController alloc]init];
//    
//    roomDetailViewController.room = room;
//    [self.navigationController pushViewController:roomDetailViewController animated:YES];
//}


@end
