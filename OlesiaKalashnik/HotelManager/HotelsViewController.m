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
#import "Room.h"
#import "RoomsViewController.h"
#import "HotelsViewController.h"
#import "Reservation.h"
#import "NSManagedObject+ManagedContext.h"

@interface HotelsViewController () <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>
@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;
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

-(NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController) {
        NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
        request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[NSManagedObject managedContext] sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        NSError *error;
        [_fetchedResultsController performFetch:&error];
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"Fetch successful");
            
        }
    }
    return _fetchedResultsController;
}

-(void)setupTBView {
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
    if ([[self.fetchedResultsController sections]count] > 0) {
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else {
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    //    Hotel *hotel = self.datasource[indexPath.row];
    Hotel *hotel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = hotel.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Hotel *hotelToBeDeleted = [self.fetchedResultsController objectAtIndexPath:indexPath];
        //NSSet<Room *> *roomsToBeDeleted = hotelToBeDeleted.rooms;
        
        NSError *error;
        //for (Room *room in roomsToBeDeleted) {
            //[[NSManagedObject managedContext]deleteObject:room.reservation];
            //[[NSManagedObject managedContext]deleteObject:room];
        //}
        [[NSManagedObject managedContext]deleteObject:hotelToBeDeleted];
        [[NSManagedObject managedContext]save:&error];
        if (error) {
            NSLog(@"Error saving hotels after deletion: %@", error.localizedDescription);
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
    //Hotel *hotel = self.datasource[indexPath.row];
    Hotel *hotel = [self.fetchedResultsController objectAtIndexPath:indexPath];
    RoomsViewController *roomsVC = [[RoomsViewController alloc]init];
    roomsVC.hotel = hotel;
    [self.navigationController pushViewController:roomsVC animated: YES];
}

// NSFetchedResultsController Delegate Methods
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
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

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
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
