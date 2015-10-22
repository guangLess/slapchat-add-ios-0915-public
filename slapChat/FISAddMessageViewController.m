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
@property (nonatomic, strong) FISDataStore * dataStore;

@end

@implementation FISAddMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.textField becomeFirstResponder]; // add the keyboard first.
    // Do any additional setup after loading the view.
    self.dataStore = [FISDataStore sharedDataStore];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)saveButton:(id)sender {
    
//    [dataStore fetchData];
    
//    if (![dataStore.messages containsObject:content]){
//    [dataStore.messages addObject:content];
//    [dataStore saveContext];
//    }
    FISMessage * addMessage = [NSEntityDescription insertNewObjectForEntityForName:@"FISMessage" inManagedObjectContext:self.dataStore.managedObjectContext];
    addMessage.content =  self.textField.text;
    [self.dataStore saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //model -> present or dismiss
    //push  nav
}

@end
