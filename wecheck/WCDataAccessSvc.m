//
//  WCDataAccessSvc.m
//  wecheck
//
//  Created by Adam Cheung on 7/8/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import "WCDataAccessSvc.h"

@implementation WCDataAccessSvc

- (BOOL)isDatabaseExist
{
    // ToDo: generalize as constant
    NSString *_databasePath = [[NSBundle mainBundle] pathForResource:@"wecheck" ofType:@"sqlite" inDirectory:@"database"];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        NSLog(@"WeCheck Database Not Exist!");
        return FALSE;
    } else {
        NSLog(@"WeCheck Database Exist!");
        return TRUE;
    }
}

- (void)openDatabase
{
    NSString *_databasePath = [[NSBundle mainBundle] pathForResource:@"wecheck" ofType:@"sqlite" inDirectory:@"database"];
    if ([self isDatabaseExist]){
            
            const char *dbpath = [_databasePath UTF8String];
            
            if (sqlite3_open(dbpath, &_itemDB) == SQLITE_OK)
            {
                NSLog(@"WeCheck Database Opened!");
            } else {
                NSLog(@"WeCheck Database Failed to Open!");
            }
    }
        
}

- (void)closeDatabase
{
    sqlite3_close(_itemDB);
}

// Get an array of item categories
-(NSArray*)getCategories
{
    // Allocate a categories array
    NSMutableArray *categories = [[NSMutableArray alloc]init];
    
    // Create the query statement to get all categories
    NSString *queryStatement = [NSString stringWithFormat:@"SELECT _id, NAME FROM VW_CATEGORY"];
    
    // Prepare the query for execution
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_itemDB, [queryStatement UTF8String], -1, &statement, NULL) == SQLITE_OK)
    {
        // Iterate over all returned rows
        while (sqlite3_step(statement) == SQLITE_ROW) {
            
            int catID = sqlite3_column_int(statement, 0);
            //ToDo to get all items of the category
            NSString *catName = [NSString stringWithUTF8String:(char*)sqlite3_column_text(statement, 1)];
            
            NSLog(@">>> returning category row %@!", catName);
            
            // Create a category object and add it to the array
            WCEntityCategory *category = [[WCEntityCategory alloc]initWithCategoryID:[NSNumber numberWithInt:catID]
                                                                     andCategoryName:catName];
            [categories addObject:category];
        }
        sqlite3_finalize(statement);
    }else{
        NSLog(@"Database returned error %d: %s", sqlite3_errcode(_itemDB), sqlite3_errmsg(_itemDB));
    }
    
    // Return the categories array an mark for autorelease
    return categories;
}

@end
