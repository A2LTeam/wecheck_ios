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
    NSString *_databasePath = [[NSBundle mainBundle] pathForResource:@"wecheck" ofType:@"sqlite" inDirectory:@"database"];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        NSLog(@"WeCheck Database Not Exist!");
        return FALSE;
    } else {
        NSLog(@"WeCheck Database Exist!");
        
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_itemDB) == SQLITE_OK)
        {
            NSLog(@"WeCheck Database Opened!");
            sqlite3_close(_itemDB);
            return TRUE;
        } else {
            return FALSE;
        }
    }
}

@end
