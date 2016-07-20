//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/18/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"
#import "HotelsViewController.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation HotelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVC];
    [self setupTBView];
}

-(void)loadView {
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void)setupVC {
    [self.navigationItem setTitle:@"Hotels"];
}

-(NSArray *)datasource {
    if (!_datasource) {
        AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.managedObjectContext;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        NSError *fetchError;
        _datasource = [context executeFetchRequest:fetchRequest error:&fetchError];
        if(fetchError ) {
            NSLog(@"Error fetching from CoreData");
        }
    }
    return _datasource;
}

-(void)setupTBView {
    //call it from ViewDidLoad
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeLeading relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeLeading multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTrailing relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeTrailing multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeTop relatedBy: NSLayoutRelationEqual toItem: self.view attribute:NSLayoutAttributeTop multiplier: 1.0 constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem: self.tableView attribute: NSLayoutAttributeBottom relatedBy: NSLayoutRelationEqual toItem: self.view attribute: NSLayoutAttributeBottom multiplier: 1.0 constant:0.0];
    
    leading.active = YES;
    trailing.active = YES;
    top.active = YES;
    bottom.active = YES;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.datasource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Hotel *hotel = self.datasource[indexPath.row];
    cell.textLabel.text = hotel.name;
    
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
    Hotel *hotel = self.datasource[indexPath.row];
    RoomsViewController *roomsVC = [[RoomsViewController alloc]init];
    roomsVC.hotel = hotel;
    [self.navigationController pushViewController:roomsVC animated: YES];
}


@end
