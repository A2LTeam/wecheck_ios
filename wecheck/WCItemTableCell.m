//
//  WCItemTableCell.m
//  wecheck
//
//  Created by Wai Lok Tsang on 6/29/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCItemTableCell.h"

@implementation WCItemTableCell

- (id)initWithItem:(WCItem*)wcItem {
    self.itemNameLabel.text = [wcItem _itemNameEn];
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
