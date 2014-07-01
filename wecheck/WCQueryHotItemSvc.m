//
//  WCQueryHotItemSvc.m
//  wecheck
//
//  Created by Wai Lok Tsang on 7/1/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCQueryHotItemSvc.h"
#import "WCItem.h"

@implementation WCQueryHotItemSvc

- (NSArray *) queryHotItem:(WCQueryHotItemParam *) queryHotItemParam {
    
    NSArray *items = [[NSArray alloc] initWithObjects:
              [[WCItem alloc] initWithItemId:[NSNumber numberWithInt:1] withItemNameEn:@"Item 1" withItemNameTc:@""],
              [[WCItem alloc] initWithItemId:[NSNumber numberWithInt:1] withItemNameEn:@"Item 2" withItemNameTc:@""],
              nil];
    
    return items;
}

@end
