//
//  WCUserHistory.h
//  wecheck
//
//  Created by Adam Cheung on 5/7/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WCItem;

@interface WCUserHistory : NSManagedObject

@property (nonatomic, retain) NSDate * accessDate;
@property (nonatomic, retain) NSNumber * itemID;
@property (nonatomic, retain) WCItem *fkItem;

@end
