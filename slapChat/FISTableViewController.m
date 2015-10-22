//
//  FISTableViewController.m
//  slapChat
//
//  Created by Joe Burgess on 6/27/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISTableViewController.h"
#import "FISDataStore.h"
#import "FISMessage.h"

@interface FISTableViewController ()

@property(nonatomic,strong)NSArray * messages;
@property(nonatomic,strong)FISDataStore * dataStore;

@end

@implementation FISTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     NOTE: logic dataStore.message.count for checking, not if it exists or not. As it always exists as a property
         [dataStore fetchData];
         if (dataStore.messages.count == 0) {
             [self generateTestData];
         }
     */
    self.dataStore = [FISDataStore sharedDataStore];
    [self reloadData];
    
    //[self.dataStore fetchData];
    //self.messages = self.dataStore.messages;
    
    NSLog(@"Messages should be all setup, what is the count of self.messages: %ld", self.messages.count);
}


-(void)reloadData{
    
    [self.dataStore fetchData];
    self.messages = self.dataStore.messages;
    [self.tableView reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [self reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"When does this get called!");
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"Creating a new cell!!!");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell" forIndexPath:indexPath];

    cell.textLabel.text = [self.messages[indexPath.row] content];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[self.messages[indexPath.row] creatAt]];
    return cell;
}

//-(void)generateTestData{
//
//    FISDataStore * dataStore = [FISDataStore sharedDataStore];
//
//    FISMessage * message1 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:dataStore.managedObjectContext];
//    message1.content = @"so sunny";
//    message1.creatAt = [NSDate dateWithTimeIntervalSinceNow:-500];
//
//    FISMessage * message2 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:dataStore.managedObjectContext];
//    message2.content = @"so flat";
//    message2.creatAt = [NSDate dateWithTimeIntervalSinceNow:100];
//
//    FISMessage * message3 = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:dataStore.managedObjectContext];
//    message3.content = @"so peaceful";
//    message3.creatAt = [NSDate dateWithTimeIntervalSinceNow:9500];
//
//    [dataStore saveContext];
//
//}

@end


