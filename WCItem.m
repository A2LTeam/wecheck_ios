//
//  WCItem.m
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCItem.h"

@implementation WCItem

//http://stackoverflow.com/questions/19784454/when-should-i-use-synthesize-explicitly

@synthesize _itemId, _itemNameEn, _itemNameTc;

- (id)initWithItemId:(NSNumber *)itemId
     withItemNameEn:(NSString *)itemNameEn
      withItemNameTc:(NSString *)itemNameTc {
    
    if (self = [self init]) {
        self._itemId = itemId;
        self._itemNameEn = itemNameEn;
        self._itemNameTc = itemNameTc;
    }
    
    return self;
}

@end
