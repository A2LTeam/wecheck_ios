//
//  WCItem.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCItem : NSObject;
 
@property (nonatomic, retain)   NSNumber    *_itemId;
@property (nonatomic, retain)   NSString    *_itemNameEn;
@property (nonatomic, retain)   NSString    *_itemNameTc;


- (id)initWithItemId:(NSNumber*)itemId
                        withItemNameEn:(NSString *)itemNameEn
                        withItemNameTc:(NSString *)itemNameTc;


@end
