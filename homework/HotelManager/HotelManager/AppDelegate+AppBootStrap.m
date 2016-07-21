//
//  AppDelegate+AppBootStrap.m
//  HotelManager
//
//  Created by Sung Kim on 7/20/16.
//  Copyright © 2016 Sung Kim. All rights reserved.
//

#import "AppDelegate+AppBootStrap.h"
#import "Hotel.h"
#import "Room.h"


@implementation AppDelegate (AppBootStrap)

- (void)loadDataFromJSON
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];
    NSError *error;
    NSInteger count = [self.managedObjectContext countForFetchRequest:request error:&error];
    
    if (count == 0) {
        NSDictionary *hotels = [NSDictionary new];
        NSDictionary *rooms = [NSDictionary new];
        NSString *jsonPath = [[NSBundle mainBundle]pathForResource:@"hotel" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSError *jsonError;
        NSDictionary *rootObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error serializing data. Error: %@", jsonError);
        }
        else {
            hotels = rootObject[@"Hotels"];
            for (NSDictionary *hotel in hotels) {
                Hotel *newHotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
                newHotel.name = hotel[@"name"];
                newHotel.location = hotel[@"location"];
                newHotel.stars = hotel[@"stars"];
                
                rooms = hotel[@"rooms"];
                
                NSMutableSet *roomsCollection = [[NSMutableSet alloc]init];
                
                for (NSDictionary *room in rooms) {
                    Room *newRoom = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
                    newRoom.number = room[@"number"];
                    newRoom.beds = room[@"beds"];
                    newRoom.rate = room[@"rate"];
                    
                    newRoom.hotel = newHotel;
                    
                    [roomsCollection addObject:newRoom];
                }
                newHotel.room = roomsCollection;
            }
            NSError *saveError;
            BOOL isSaved = [self.managedObjectContext save:&saveError];
            
            if (isSaved) {
                NSLog(@"Success saving...");
            }
            else {
                NSLog(@"Error saving...");
            }
        }
    }
    else {
        NSLog(@"Database contains data...");
    }
}

@end
