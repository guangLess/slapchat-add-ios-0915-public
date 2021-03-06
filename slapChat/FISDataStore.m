//
//  FISDataStore.m
//  playingWithCoreData
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISDataStore.h"
#import "FISMessage+CoreDataProperties.h"

@interface FISDataStore ()
@property(strong,nonatomic,readwrite)NSArray * messages;
@end

@implementation FISDataStore



@synthesize managedObjectContext = _managedObjectContext;



+ (instancetype)sharedDataStore {
    static FISDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDataStore alloc] init];
    });

    return _sharedDataStore;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (void)fetchData
{
    // perform a fetch request to fill an array property on your datastore
    // fetchData NSFetchRequest > execute messages.
    //self.messages is an NSArray, we don't have to alloc/init IT because we are having it equal something that RETURNS an NSarray.

    NSFetchRequest * request = [NSFetchRequest fetchRequestWithEntityName:@"FISMessage"];
    self.messages = [self.managedObjectContext executeFetchRequest:request error:nil];
    
    if (self.messages.count == 0) {
        [self generateTestData];
        [self fetchData];
    }
}


- (void)generateTestData {
    
    FISMessage * message1 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:self.managedObjectContext];
    message1.content = @"so sunny";
    message1.creatAt = [NSDate dateWithTimeIntervalSinceNow:-8888500]; //[dateFormatter setDateFormat:@"E, d M y"];
    
    /*
     NSString* dateString = "2011-08-12T12:20:00Z";
     NSDateFormatter* fmt = [NSDateFormatter new];
     [fmt setDateFormat:"yyyy-MM-dd'T'HH:mm:ss'Z'"];
     NSDate* date = [fmt dateFromString:dateString];
     */
    
    NSDateFormatter* fmt = [NSDateFormatter new];
    [fmt setDateFormat:@"yyyy-MM-dd"];
    NSString * dateString1 = @"2001-08-12";
    NSDate * date1 = [fmt dateFromString:dateString1];

    
    FISMessage * message2 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:self.managedObjectContext];
    message2.content = @"so flat";
    message2.creatAt = date1;
    
    FISMessage * message3 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:self.managedObjectContext];
    message3.content = @"so peaceful";
    message3.creatAt = [NSDate dateWithTimeIntervalSinceNow:9500];
    
    [self saveContext];
}

#pragma mark - Core Data Stack

// Managed Object Context property getter. This is where we've dropped our "boilerplate" code.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"slapChat.sqlite"];

    NSError *error = nil;

    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"slapChat" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
@end
