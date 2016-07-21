//
//  AppDelegate.m
//  ObjectManager
//
//  Created by Derek Graham on 7/18/16.
//  Copyright © 2016 Derek Graham. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "Hotel.h"
#import "Room.h"
#import "NSManagedObjectContext+CoreDataStack.h"

@interface AppDelegate ()
@property (strong, nonatomic) ViewController *viewController ;
@property (strong, nonatomic) UINavigationController *navController;

@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self setupRootViewController];
    
    _myManagedObjectContext = [[NSManagedObjectContext alloc]init];
    [_myManagedObjectContext loadDataFromJSON];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [_myManagedObjectContext saveContext];
}

- (void) setupRootViewController
{
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.viewController = [[ViewController alloc] init];
    self.navController = [[UINavigationController alloc]initWithRootViewController: self.viewController];
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
}

//- (void) bootStrapApp {
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
//    NSError *error;
//    
//    NSInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
//    
//    if (count == 0 ){
//        NSDictionary *hotels = [NSDictionary new];
//        NSDictionary *rooms = [NSDictionary new];
//        
//        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotels" ofType:@"json"];
//        
//        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
//        
//        NSError *jsonError;
//        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
//        
//        NSLog(@"%@", rootObject);
//        
//        if (jsonError) { NSLog(@"Error serializing data, Error: %@", jsonError);
//        } else
//        {
//            hotels = rootObject[@"Hotels"];
//            
//            for (NSDictionary *hotel in hotels) {
//                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
//                
//                newHotel.name = hotel [@"name"];
//                newHotel.location =  hotel [@"location"];
//                newHotel.rating =  hotel [@"stars"];
//                
//                
//                rooms = hotel[@"rooms"];
//                
//                NSMutableSet *roomsSet = [[NSMutableSet alloc]init];
//                
//                for (NSDictionary *room in rooms){
//                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
//                    
//                    newRoom.roomNumber = room [@"number"];
//                    newRoom.beds = room[@"beds"];
//                    newRoom.rate = room [@"rate"];
//                    
//                    newRoom.hotel = newHotel;
//                    
//                    NSLog(@"%@", newRoom);
//                    [roomsSet addObject:newRoom];
//                }
//                newHotel.rooms = roomsSet;
//                
//            }
//            
//            NSError *saveError;
//            BOOL isSaved = [self.managedObjectContext save: &saveError];
//            
//            if(isSaved) {
//                NSLog(@"success saving");
//                
//            } else {
//                NSLog(@"error saving");
//                
//            }
//        }
//    }
//    else {
//        NSLog(@"database contains data, yay");
//    }
//}


@end
