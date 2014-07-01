//
//  WCItem.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCItem : NSObject;
 
@property    NSNumber *itemId;
@property    NSString  *itemNameEn;
@property    NSString  *itemNameTc;


- (id)initWithItemId:(NSNumber*)itemId
                        withItemNameEn:(NSString *)itemNameEn
                        withItemNameTc:(NSString *)itemNameTc;


@end
