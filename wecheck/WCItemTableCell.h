//
//  WCItemTableCell.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCItem.h"

@interface WCItemTableCell : UITableViewCell


//@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *itemNameLabel;

- (id)initWithItem:(WCItem*)wcItem;

@end
