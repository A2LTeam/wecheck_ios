//
//  WCShopItem.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WCItem, WCShop;

@interface WCShopItem : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * itemID;
@property (nonatomic, retain) NSNumber * shopID;
@property (nonatomic, retain) NSDecimalNumber * lastPrice;
@property (nonatomic, retain) NSDate * lastUpdDate;
@property (nonatomic, retain) WCShop *fkShop;
@property (nonatomic, retain) WCItem *fkItem;

@end
