//
//  AvailabilityViewController.m
//  HotelManager
//
//  Created by Sung Kim on 7/19/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "AvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "Room.h"
#import "Hotel.h"
#import "BookViewController.h"
#import "ReservationService.h"

@interface AvailabilityViewController () <UITableViewDelegate, UITableViewDataSource>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSArray *datasource;

@end

@implementation AvailabilityViewController

- (NSArray *)datasource
{

    if (!_datasource) {
        ReservationService *operator = [[ReservationService alloc]init];
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
//        request.predicate = [NSPredicate predicateWithFormat:@"startDate <= %@ AND endDate >= %@", self.endDate, self.startDate];
//        
//        NSError *error;
//        NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:&error];
//        
//        if (error) {
//            NSLog(@"Error with fetch...");
//        }
//        else {
//            NSMutableArray *unavailableRooms = [[NSMutableArray alloc]init];
//            for (Reservation *reservation in results) {
//                [unavailableRooms addObject:reservation.room];
//            }
//        
//            NSFetchRequest *checkRequest = [NSFetchRequest fetchRequestWithEntityName:@"Room"];
//            checkRequest.predicate = [NSPredicate predicateWithFormat:@"NOT self IN %@", unavailableRooms];
//
//            NSError *availableError;
//            _datasource = [delegate.managedObjectContext executeFetchRequest:checkRequest error:&availableError];
//            
//            if (availableError) {
//                NSLog(@"Error with second fetch...");
//            }
//            else {
//                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"number" ascending:YES];
//                _datasource = [_datasource sortedArrayUsingDescriptors:@[sort]];
//            }
//        }
        _datasource = [operator checkAvailabilityWithStartDate:self.startDate endDate:self.endDate];
        
    }
    
    return _datasource;
}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Rooms"];
    [self setupTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Room *room = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Room: %i (%i beds, $%0.2f per night)", room.number.intValue, room.beds.intValue, room.rate.floatValue];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Room *room = self.datasource[indexPath.row];
    BookViewController *bookViewController = [[BookViewController alloc]init];
    bookViewController.room = room;
    bookViewController.endDate = self.endDate;
    bookViewController.startDate = self.startDate;
    [self.navigationController pushViewController:bookViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage *headerImage = [UIImage imageNamed:@"hotel"];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:headerImage];
    imageView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    
    return imageView;
}


@end
