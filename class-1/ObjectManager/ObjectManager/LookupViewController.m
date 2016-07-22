//
//  LookupViewController.m
//  ObjectManager
//
//  Created by Derek Graham on 7/20/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "LookupViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "Room.h"
#import "Hotel.h"
#import "ReservationService.h"

#import "AppDelegate+CoreDataStack.h"

@interface LookupViewController () <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, NSFetchedResultsControllerDelegate>
//@property  (strong, nonatomic) NSArray *datasource;

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSFetchRequest *request;
@property (strong, nonatomic) ReservationService *operator;


@end

@implementation LookupViewController




- (void)loadView{
    [super loadView];
    _operator = [[ReservationService alloc]init];
    [self.view setBackgroundColor:[UIColor blackColor]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"Search"];
    [self setupTableView];
}

- (void) setupTableView {
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:self.tableView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    
    leading.active = YES;
    top.active = YES;
    bottom.active = YES;
    trailing.active = YES;
}

//- (void)setDatasource:(NSArray *)datasource{
//    _datasource = datasource;
//    [self.tableView reloadData];
//    
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return [self.datasource count];
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    if ([[self.fetchedResultsController sections]count] > 0){
        id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections]objectAtIndex:section];
        
        return [sectionInfo numberOfObjects];
    } else {
        return 0;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
//    Reservation *reservation = self.datasource[indexPath.row ];
    Reservation *reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"Name: %@, Hotel: %@", reservation.guest.firstName, reservation.room.hotel.name];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44.0;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        Reservation * reservation = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [AppDelegate.managedObjectContext deleteObject:reservation];
        [AppDelegate.managedObjectContext save:nil];
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0,0.0,CGRectGetWidth(self.view.frame), 44.0)];
    
    searchBar.delegate = self;
    
    return searchBar;
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (!_fetchedResultsController){
        
        _fetchedResultsController = [_operator showAllReservations];
        
    }
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ( [searchText length] == 0 ) {
        self.fetchedResultsController.fetchRequest.predicate = nil;
        
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error)
        {
            NSLog(@"Error: %@", error.localizedDescription);
            
        } else {
            
            NSLog(@"fetch success");
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchText = searchBar.text;
    
//    self.request.predicate = [NSPredicate predicateWithFormat:@"guest.firstName == %@ || guest.lastName == %@ || guest.email == %@", searchText, searchText, searchText];
//
//    
    NSError *error;
    self.fetchedResultsController.fetchRequest.predicate = [NSPredicate predicateWithFormat:@"guest.firstName == %@ || guest.lastName == %@ || guest.email == %@", searchText, searchText, searchText];
    [self.fetchedResultsController performFetch:&error];
    
    
    if (error)
    {
        NSLog(@"Error: %@", error.localizedDescription);
        
    } else {

        NSLog(@"fetch success");
        
        
        [self.tableView reloadData];
        
//        self.datasource = results;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}
-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath]
//                    atIndexPath:indexPath];
            break;
//
        default:
            break;
            
    }
    
}
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type{
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

@end
