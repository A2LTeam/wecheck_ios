//
//  WCFavoriteTableTableViewController.h
//  wecheck
//
//  Created by Adam Cheung on 23/6/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "WCHistoryItemTableView.h"

@interface WCFavoriteViewController : UIViewController

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (strong, nonatomic) IBOutlet UIView *historyView;
@property (strong, nonatomic) IBOutlet UIView *watchListView;
@property (strong, nonatomic) IBOutlet WCHistoryItemTableView *historyItemTableView;
@property (strong, nonatomic) IBOutlet UITableView *watchListItemTableView;

- (IBAction)segmentedValueChanged:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *address;
@property (strong, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *contactDB;
@end
