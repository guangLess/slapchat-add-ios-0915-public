//
//  FISMessage+CoreDataProperties.h
//  slapChat
//
//  Created by Guang on 10/21/15.
//  Copyright © 2015 Joe Burgess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "FISMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface FISMessage (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *content;
@property (nullable, nonatomic, retain) NSDate *creatAt;

@end

NS_ASSUME_NONNULL_END
