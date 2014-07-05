//
//  WCShopBranch.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WCShop;

@interface WCShopBranch : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * shopID;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phoneNo;
@property (nonatomic, retain) WCShop *fkShop;

@end
