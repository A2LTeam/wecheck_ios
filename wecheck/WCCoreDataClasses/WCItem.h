//
//  WCItem.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WCShopItem, WCSubCategory;

@interface WCItem : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * nameEN;
@property (nonatomic, retain) NSString * itemCode;
@property (nonatomic, retain) NSString * brandEN;
@property (nonatomic, retain) NSString * nameTC;
@property (nonatomic, retain) NSString * brandTC;
@property (nonatomic, retain) NSString * nameSC;
@property (nonatomic, retain) NSString * brandSC;
@property (nonatomic, retain) NSNumber * subCategoryID;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) WCSubCategory *fkSubCategory;
@property (nonatomic, retain) NSSet *fkShopItems;
@end

@interface WCItem (CoreDataGeneratedAccessors)

- (void)addFkShopItemsObject:(WCShopItem *)value;
- (void)removeFkShopItemsObject:(WCShopItem *)value;
- (void)addFkShopItems:(NSSet *)values;
- (void)removeFkShopItems:(NSSet *)values;

// testing
- (id)initWithItemId:(NSNumber*)itemId
      withItemNameEn:(NSString *)itemNameEn
      withItemNameTc:(NSString *)itemNameTc;

@end
