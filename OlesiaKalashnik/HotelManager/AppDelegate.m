//
//  AppDelegate.m
//  HotelManager
//
//  Created by Olesia Kalashnik on 7/18/16.
//  Copyright © 2016 Olesia Kalashnik. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "CoreDataStack.h"

@interface AppDelegate ()
@property (strong, nonatomic) UINavigationController *navC;
@property (strong, nonatomic) ViewController *viewC;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupRootVC];
    [CoreDataStack.shared bootstrapApp];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [CoreDataStack.shared saveContext];
}

-(void) setupRootVC {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.viewC = [[ViewController alloc] init];
    self.navC = [[UINavigationController alloc ]initWithRootViewController: self.viewC];
    self.window.rootViewController = self.navC;
    
    [self.window makeKeyAndVisible];
}



@end
