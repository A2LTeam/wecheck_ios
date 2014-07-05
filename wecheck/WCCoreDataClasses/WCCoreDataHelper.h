//
//  WCCoreDataHelper.h
//  wecheck
//
//  Created by Adam Cheung on 25/6/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "CHCSVParser.h"
#import "WCSubCategory.h"

@interface WCCoreDataHelper : NSObject<CHCSVParserDelegate>

@property (nonatomic, readonly) NSManagedObjectContext       *context;
@property (nonatomic, readonly) NSManagedObjectModel         *model;
@property (nonatomic, readonly) NSPersistentStoreCoordinator *coordinator;
@property (nonatomic, readonly) NSPersistentStore            *store;

@property (nonatomic, readonly) NSMutableArray *currentRow;
@property (nonatomic, readonly) WCSubCategory *subCategory;

- (void)setupCoreData;
- (void)saveContext;
- (void)setupSystemData;
@end
