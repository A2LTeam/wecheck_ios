//
//  WCItem.m
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import "WCItem.h"
#import "WCShopItem.h"
#import "WCSubCategory.h"


@implementation WCItem

@synthesize id;
@synthesize nameEN;
@synthesize nameTC;

@dynamic itemCode;
@dynamic brandEN;
@dynamic brandTC;
@dynamic nameSC;
@dynamic brandSC;
@dynamic subCategoryID;
@dynamic orderIndex;
@dynamic fkSubCategory;
@dynamic fkShopItems;


- (id)initWithItemId:(NSNumber *)itemId
      withItemNameEn:(NSString *)itemNameEn
      withItemNameTc:(NSString *)itemNameTc {
    
    if (self = [self init]) {
        self.id = itemId;
        self.nameEN = itemNameEn;
        self.nameTC = itemNameTc;
    }
    
    return self;
}

@end
