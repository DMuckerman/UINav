//
//  UINavFilesTableViewController.m
//  UINav
//
//  Created by Daniel Muckerman on 5/5/14.
//  Copyright (c) 2014 Finalesoft. All rights reserved.
//

#import "UINavFilesTableViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Cloud/Cloud.h>
#import "YSViewer.h"

@interface UINavFilesTableViewController () <CLAPIEngineDelegate>

@property (nonatomic, strong) NSArray *drops; // drops/items list
@property (strong, nonatomic) YSViewer *viewer;
@end

@implementation UINavFilesTableViewController

@synthesize userName, passWord;

- (NSArray *)drops {
    if (!_drops) _drops = [[NSArray alloc] init];
    return _drops;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.viewer = YSViewer.new;
    
    self.navigationController.title = @"Drops";
    
    UIColor *cellColour = [UIColor colorWithRed:0.000 green:0.169 blue:0.212 alpha:1.000];
    UIColor *seperatorColour = [UIColor colorWithRed:0.345 green:0.431 blue:0.459 alpha:1.000];
    self.tableView.backgroundColor = cellColour;
    self.tableView.separatorColor = seperatorColour;
    
    CLAPIEngine *myEngine = [CLAPIEngine engineWithDelegate:self];
	myEngine.email = self.userName;
	myEngine.password = self.passWord;
	
	//--------Get Recent Items--------
    [myEngine getItemListStartingAtPage:1 itemsPerPage:100 userInfo:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.drops.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UIColor *cellColour = [UIColor colorWithRed:0.000 green:0.169 blue:0.212 alpha:1.000];
    UIColor *cellTextColour = [UIColor colorWithRed:0.576 green:0.631 blue:0.631 alpha:1.000];
    UIColor *cellDetailTextColour = [UIColor colorWithRed:0.796 green:0.294 blue:0.086 alpha:1.000];
    UIColor *selectedColour = [UIColor colorWithRed:0.027 green:0.212 blue:0.259 alpha:1.000];
    cell.backgroundColor = cellColour;
    cell.textLabel.textColor = cellTextColour;
    cell.detailTextLabel.textColor = cellDetailTextColour;
    
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = selectedColour;
    [cell setSelectedBackgroundView:bgColorView];
    
    CLWebItem *drop = self.drops[indexPath.row];
    cell.textLabel.text = drop.name;
    cell.detailTextLabel.text = [drop.remoteURL absoluteString];
    return cell;
}

- (void)itemListRetrievalSucceeded:(NSArray *)items connectionIdentifier:(NSString *)connectionIdentifier userInfo:(id)userInfo {
	self.drops = [items copy];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CLWebItem *drop = self.drops[indexPath.row];
    
    if(!drop.type) {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager downloadWithURL:drop.contentURL
                     options:0
                    progress:^(NSInteger receivedSize, NSInteger expectedSize)
     {
         // progression tracking code should go here
         // my attempts at a progress bar failed. now a 2.0 feature
         
     }
                   completed:^(UIImage *thisImage, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (thisImage)
         {
             self.viewer.image = thisImage;
             [self.viewer show];
         }
     }];
    } else {
        [[UIApplication sharedApplication] openURL:drop.URL];
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
