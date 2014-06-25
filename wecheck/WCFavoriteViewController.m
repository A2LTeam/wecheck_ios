//
//  WCFavoriteTableTableViewController.m
//  wecheck
//
//  Created by Adam Cheung on 23/6/14.
//  Copyright (c) 2014 Adam Cheung. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "WCFavoriteViewController.h"
#import "WCAppDelegate.h"

@interface WCFavoriteViewController ()

@end

@implementation WCFavoriteViewController
@synthesize historyView, watchListView, historyItemTableView, watchListItemTableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self initInternalDB];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.historyView.hidden = NO;
            self.watchListView.hidden = YES;
            
            [self.historyItemTableView reloadData];
            
            break;
        case 1:
            self.historyView.hidden = YES;
            self.watchListView.hidden = NO;
            break;
        default:
            break;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = @"testing";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Row Selected" message:@"You've selected a row" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    // Display Alert Message
    [messageAlert show];
    
    WCAppDelegate *appDelegate = (WCAppDelegate*) [[UIApplication sharedApplication] delegate];
    

    NSManagedObject *newHistory;
    newHistory = [NSEntityDescription
                  insertNewObjectForEntityForName:@"WCUserHistory"
                  inManagedObjectContext:appDelegate.coreDataHelper.context];
    
    
    [newHistory setValue: [NSNumber numberWithInt:20] forKey:@"itemID"];
    
    [appDelegate.coreDataHelper saveContext];
    
}

// to be moved to database service
- (void)initInternalDB
{
    
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(
                                                   NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc]
                     initWithString: [docsDir stringByAppendingPathComponent:
                                      @"wecheck.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_contactDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS WC_USR_HIST (ID INTEGER PRIMARY KEY AUTOINCREMENT, ITEM_ID INTEGER, ITEM_NAME TEXT, VIEW_TM TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";
            
            if (sqlite3_exec(_contactDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                _status.text = @"Failed to create table";
            }
            sqlite3_close(_contactDB);
        } else {
            _status.text = @"Failed to open/create database";
        }
    }
    
}


@end
