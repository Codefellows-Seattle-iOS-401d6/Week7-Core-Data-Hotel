//
//  HotelsViewController.m
//  HotelManager
//
//  Created by Sung Kim on 7/18/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "HotelsViewController.h"
#import "Hotel.h"
//#import "AppDelegate.h"
#import "RoomsViewController.h"
#import "NSManagedObjectContext+NSManagedObjectContext.h"

@interface HotelsViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate>

//@property (strong, nonatomic) NSArray *datasource;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation HotelsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void)loadView
{
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

//- (NSArray *)datasource
//{
//    if (!_datasource) {
//        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
//        NSManagedObjectContext *context = delegate.managedObjectContext;
//        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
//        NSError *fetchError;
//        _datasource = [context executeFetchRequest:request error:&fetchError];
//        
//        if (fetchError) {
//            NSLog(@"Error fetching from Core Data");
//        }
//    }
//    
//    return _datasource;
//}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (!_fetchedResultsController) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[NSManagedObjectContext managerContext] sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        
        NSError *error;
        [_fetchedResultsController performFetch:&error];
        
        if (error) {
            NSLog(@"%@", error.localizedDescription);
        }
        else {
            NSLog(@"Fetch successful!");
        }
    }
    return _fetchedResultsController;
}

- (void)setupTableView
{
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.datasource.count;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self.fetchedResultsController sections]count] > 0) {
        id<NSFetchedResultsSectionInfo> sectionsInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionsInfo numberOfObjects];
    }
    else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Hotel *hotel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = hotel.name;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 150.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImage *headerImage = [UIImage imageNamed:@"hotel"];
    UIImageView *headerView = [[UIImageView alloc]initWithImage:headerImage];
    headerView.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 150.0);
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.clipsToBounds = YES;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Hotel *hotel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    RoomsViewController *roomsViewController = [[RoomsViewController alloc]init];
    roomsViewController.hotel = hotel;
    NSLog(@"This is the room count: %lu", roomsViewController.hotel.room.count);
    [self.navigationController pushViewController:roomsViewController animated:YES];
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Hotel *hotel = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [[NSManagedObjectContext managerContext]deleteObject:hotel];
        [[NSManagedObjectContext managerContext]save:nil];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - FetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

@end
