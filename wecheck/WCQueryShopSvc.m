//
//  WCQueryShopSvc.m
//  wecheck
//
//  Created by Wai Lok Tsang on 7/1/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCQueryShopSvc.h"

@implementation WCQueryShopSvc

- (NSArray *) queryShop:(WCQueryShopParam *) queryHotItemParam {
    
    NSArray *shops = [[NSArray alloc] initWithObjects:
                      @"百佳",
                      @"惠康",
                      @"Market Place",
                      nil];
    
    return shops;
}

@end
