//
//  FISAddMessageViewController.m
//  slapChat
//
//  Created by Guang on 10/21/15.
//  Copyright © 2015 Joe Burgess. All rights reserved.
//

#import "FISAddMessageViewController.h"
#import "FISDataStore.h"
#import "FISMessage.h"

@interface FISAddMessageViewController ()
- (IBAction)cancelButton:(id)sender;
- (IBAction)saveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation FISAddMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)saveButton:(id)sender {
    
    FISDataStore * dataStore = [FISDataStore sharedDataStore];
//    [dataStore fetchData];
    
//    if (![dataStore.messages containsObject:content]){
//    [dataStore.messages addObject:content];
//    [dataStore saveContext];
//    }
    FISMessage * addMessage = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:dataStore.managedObjectContext];
    addMessage.content =  self.textField.text;
    [dataStore saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //model -> present or dismiss
    //push  nav
}

@end
