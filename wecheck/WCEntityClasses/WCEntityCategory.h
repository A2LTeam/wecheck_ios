//
//  WCEntityCategory.h
//  wecheck
//
//  Created by Adam Cheung on 10/8/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCEntityCategory : NSObject
{
    NSNumber *id;
    NSString *categoryName;
}

@property (nonatomic, retain) NSNumber* id;
@property (nonatomic, retain) NSString* categoryName;

-(id)initWithCategoryID:(NSNumber*)catID
        andCategoryName:(NSString*)catName;
@end
