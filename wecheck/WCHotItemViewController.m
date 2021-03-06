//
//  WCHotItemViewController.m
//  wecheck
//
//  Created by Wai Lok Tsang on 6/24/14.
//  Copyright (c) 2014 Wai Lok Tsang. All rights reserved.
//

#import "WCHotItemViewController.h"
#import "WCShopHotItemViewController.h"
#import "WCAllHotItemViewController.h"
#import "WCItem.h"
#import "WCItemTableCell.h"
#import "WCQueryHotItemSvc.h"
#import "WCQueryShopSvc.h"

@interface WCHotItemViewController () {
    
    NSArray *_shops;
    //NSArray *itemTitles;
    
    //NSArray *_shops;
    NSArray *_items;
    
    WCQueryHotItemSvc *_queryHotItemSvc;
    WCQueryShopSvc *_queryShopSvc;
}

@end

@implementation WCHotItemViewController
@synthesize shopHottestItemView, shopHottestItemTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // query shop
    _queryShopSvc = [WCQueryShopSvc alloc];
    // setup query parameters
    WCQueryShopParam *shopParam = [WCQueryShopParam alloc];
    _shops = [_queryShopSvc queryShop:shopParam];
    
    // query hot item
    _queryHotItemSvc = [WCQueryHotItemSvc alloc];
    // setup query parameters
    WCQueryHotItemParam *hotItemParam = [WCQueryHotItemParam alloc];
    _items = [_queryHotItemSvc queryHotItem:hotItemParam];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            return [_items count];
            break;
        case 1:
            return [_shops count];
            break;
        default:
            break;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    WCItemTableCell *itemCell;
    
    UITableViewCell *shopCell;

    // Configure the cell...
    //cell.shopNameLabel.text = [shopTitles objectAtIndex:indexPath.row];
    //cell.shopLogoImage.image = [UIImage imageNamed:[shopLogos objectAtIndex:indexPath.row]];
    
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            itemCell = [tableView dequeueReusableCellWithIdentifier:@"ItemTableCell" forIndexPath:indexPath];
            itemCell.itemNameLabel.text = [[_items objectAtIndex:indexPath.row] nameEN];
            NSLog(@"##########%@", [[_items objectAtIndex:indexPath.row] nameEN]);
            cell = itemCell;
            break;
        case 1:
            shopCell = [tableView dequeueReusableCellWithIdentifier:@"ShopTableCell" forIndexPath:indexPath];
            shopCell.textLabel.text =[_shops objectAtIndex:indexPath.row];
            cell = shopCell;
            break;
        default:
            break;
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cell index   ##########%ld", indexPath.row);
    UIViewController *selectedView;
    
    NSLog(@"segment index##########%ld", (long)self.segmentedControl.selectedSegmentIndex);
    
    switch (self.segmentedControl.selectedSegmentIndex)
    {
        case 0:
            selectedView = [self.storyboard instantiateViewControllerWithIdentifier:@"AllHotItem"];
            selectedView.title = [[_items objectAtIndex:indexPath.row] nameEN];
            break;
        case 1:
            selectedView = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopHotItem"];
            selectedView.title = [_shops objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }

 
    [self.navigationController pushViewController:selectedView animated:YES];
}

/*
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sende sr {
    
    NSLog(@"##########%@", [segue identifier]);
    if ([[segue identifier] isEqualToString:@"ShowShopItem"]) {
        
        WCShopHotItemViewController *shopItemViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.shopHottestItemTableView indexPathForSelectedRow];
        
        shopItemViewController.title = [shopTitles objectAtIndex:indexPath.row];
    }
    
}
*/
- (IBAction)segmentedValueChanged:(UISegmentedControl *)sender {
    
    [self.shopHottestItemTableView reloadData];
    
    /*
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.allHottestItemView.hidden = NO;
            self.shopHottestItemView.hidden = YES;
            break;
        case 1:
            self.allHottestItemView.hidden = YES;
            self.shopHottestItemView.hidden = NO;
            break;
        default:
            break;
    }
     */
}
@end
