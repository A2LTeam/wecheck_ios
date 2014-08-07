//
//  WCDataAccessSvc.h
//  wecheck
//
//  Created by Adam Cheung on 7/8/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface WCDataAccessSvc : NSObject

@property (nonatomic) sqlite3 *itemDB;

- (BOOL)isDatabaseExist;
@end
