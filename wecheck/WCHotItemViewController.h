//
//  WCHotItemViewController.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/24/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCHotItemViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIView *allHottestItemView;
@property (strong, nonatomic) IBOutlet UIView *shopHottestItemView;
@property (strong, nonatomic) IBOutlet UITableView *allHottestItemTableView;
@property (strong, nonatomic) IBOutlet UITableView *shopHottestItemTableView;

- (IBAction)segmentedValueChanged:(id)sender;

@end
