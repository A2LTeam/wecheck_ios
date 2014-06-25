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

@interface WCHotItemViewController () {
    
    NSArray *shopTitles;
}

@end

@implementation WCHotItemViewController
@synthesize allHottestItemView, shopHottestItemView, allHottestItemTableView, shopHottestItemTableView;

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
    
    shopTitles = [[NSArray alloc] initWithObjects:
                  @"百佳",
                  @"惠康",
                  @"Market Place",
                  nil];
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
    return [shopTitles count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ShopTableCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.textLabel.text =[shopTitles objectAtIndex:indexPath.row];
    // Configure the cell...
    //cell.shopNameLabel.text = [shopTitles objectAtIndex:indexPath.row];
    //cell.shopLogoImage.image = [UIImage imageNamed:[shopLogos objectAtIndex:indexPath.row]];
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
            break;
        case 1:
            selectedView = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopHotItem"];
            break;
        default:
            break;
    }

    selectedView.title = [shopTitles objectAtIndex:indexPath.row];
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
}
@end
