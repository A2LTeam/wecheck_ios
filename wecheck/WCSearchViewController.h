//
//  WCViewController.h
//  wecheck
//
//  Created by Wai Lok Tsang on 6/20/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCAppDelegate.h"
#import "WCSearchItemTableView.h"

@interface WCSearchViewController : UIViewController< UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIView *listCategoryView;

@end
