//
//  WCShop.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface WCShop : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * orderIndex;
@property (nonatomic, retain) NSString * nameTC;
@property (nonatomic, retain) NSString * nameEN;
@property (nonatomic, retain) NSString * nameSC;

@end
