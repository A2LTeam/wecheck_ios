//
//  WCItem.m
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCItem.h"

@implementation WCItem
@synthesize itemId, itemNameEn, itemNameTc;

- (id)initWithItemId:(NSNumber *)itemId
     withItemNameEn:(NSString *)itemNameEn
      withItemNameTc:(NSString *)itemNameTc {
    
    if (self = [self init]) {
        self.itemId = itemId;
        self.itemNameEn = itemNameEn;
        self.itemNameTc = itemNameTc;
    }
    
    return self;
}

@end
