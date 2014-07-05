//
//  WCShop.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WCShopBranch, WCShopItem;

@interface WCShop : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * nameTC;
@property (nonatomic, retain) NSString * nameEN;
@property (nonatomic, retain) NSString * nameSC;
@property (nonatomic, retain) NSSet *fkShopItems;
@property (nonatomic, retain) NSSet *fkShopBranches;
@end

@interface WCShop (CoreDataGeneratedAccessors)

- (void)addFkShopItemsObject:(WCShopItem *)value;
- (void)removeFkShopItemsObject:(WCShopItem *)value;
- (void)addFkShopItems:(NSSet *)values;
- (void)removeFkShopItems:(NSSet *)values;

- (void)addFkShopBranchesObject:(WCShopBranch *)value;
- (void)removeFkShopBranchesObject:(WCShopBranch *)value;
- (void)addFkShopBranches:(NSSet *)values;
- (void)removeFkShopBranches:(NSSet *)values;

@end
