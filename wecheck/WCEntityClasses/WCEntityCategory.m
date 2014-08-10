//
//  WCEntityCategory.m
//  wecheck
//
//  Created by Adam Cheung on 10/8/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import "WCEntityCategory.h"

@implementation WCEntityCategory

@synthesize id;
@synthesize categoryName;

-(id)initWithCategoryID:(NSNumber*)catID
        andCategoryName:(NSString*)catName
{
    self = [super init];
    if(self) {
        self.id = catID;
        self.categoryName = catName;
    }
    return self;
}

@end
