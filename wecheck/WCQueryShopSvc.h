//
//  WCQueryShopSvc.h
//  wecheck
//
//  Created by Wai Lok Tsang on 7/1/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCQueryShopParam.h"

@interface WCQueryShopSvc : NSObject

- (NSArray *) queryShop:(WCQueryShopParam *) queryHotItemParam;

@end
