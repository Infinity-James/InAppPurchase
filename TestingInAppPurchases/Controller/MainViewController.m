//
//  MainViewController.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "DetailViewController.h"
#import "IAPProduct.h"
#import "MainViewController.h"
#import "ProductCell.h"
#import "SpecificIAPHelper.h"

@import StoreKit;

#pragma mark - Constants & Static Variables

/**	The unique identifier for reusing the cells for the tableView.	*/
static NSString *const CellIdentifier	= @"CellIdentifier";

#pragma mark - Main View Controller Private Class Extension

@interface MainViewController () <IAPHelperProductObserver, UITableViewDataSource, UITableViewDelegate> {}

#pragma mark - Private Properties

/**	A price formatter to use whilst displaying the products.	*/
@property (nonatomic, strong)		NSNumberFormatter		*priceFormatter;
/**	A list of the products to display.	*/
@property (nonatomic, strong)		NSArray					*products;
/**	The refresh control for the table view.	*/
@property (nonatomic, strong)		UIRefreshControl		*refreshControl;
/**	The table view for this view controller.	*/
@property (nonatomic, strong)		UITableView				*tableView;

@end

#pragma mark - Main View Controller Implementation

@implementation MainViewController {}

#pragma mark - IAPHelperProductObserver Methods

/**
 *	Sent to an observer when a product has updated.
 *
 *	@param	product						The product which has been updated in some way.
 */
- (void)product:(IAPProduct *)product updatedWithStatus:(IAPHelperProductStatusUpdate)statusUpdate
{
	[self reload];
}

#pragma mark - In-App Purchase Management

/**
 *	Reloads the available in-app purchases.
 */
- (void)reload
{
	self.products						= nil;
	[self.tableView reloadData];
	[[SpecificIAPHelper sharedInstance] requestProductsWithCompletionHandler:^(BOOL success, NSArray *products)
	{
		if (success)
		{
			self.products				= products;
			[self.tableView reloadData];
		}
		
		[self.refreshControl endRefreshing];
	}];
}

/**
 *
 */
- (void)restoreCompletedTransactions
{
	[[SpecificIAPHelper sharedInstance] restoreCompletedTransactions];
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	A price formatter to use whilst displaying the products.
 *
 *	@return	A price formatter to use whilst displaying the products.
 */
- (NSNumberFormatter *)priceFormatter
{
	if (!_priceFormatter)
	{
		_priceFormatter						= [[NSNumberFormatter alloc] init];
		_priceFormatter.formatterBehavior	= NSNumberFormatterBehavior10_4;
		_priceFormatter.numberStyle			= NSNumberFormatterCurrencyStyle;
	}
	
	return _priceFormatter;
}

/**
 *	The table view for this view controller.
 *
 *	@return	The table view for this view controller.
 */
- (UITableView *)tableView
{
	if (!_tableView)
	{
		_tableView						= [[UITableView alloc] init];
		_tableView.dataSource			= self;
		_tableView.delegate				= self;
		self.refreshControl				= [[UIRefreshControl alloc] init];
		[self.refreshControl addTarget:self action:@selector(reload) forControlEvents:UIControlEventValueChanged];
		self.tableView.tableHeaderView	= self.refreshControl;
		
		[_tableView registerClass:[ProductCell class] forCellReuseIdentifier:CellIdentifier];
		
		NSDictionary *viewsDictionary	= @{@"tableView": _tableView,
											@"top"		: self.topLayoutGuide};
		[self.view addSubview:_tableView];
		_tableView.translatesAutoresizingMaskIntoConstraints	= NO;
		
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[tableView]|"
																		  options:kNilOptions
																		  metrics:nil
																			views:viewsDictionary]];
		[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|"
																		  options:kNilOptions
																		  metrics:nil
																			views:viewsDictionary]];
	}
	
	return _tableView;
}

#pragma mark - UITableViewDataSource Methods

/**
 *	Asks the data source for a cell to insert in a particular location of the table view.
 *
 *	@param	tableView					A table-view object requesting the cell.
 *	@param	indexPath					An index path locating a row in tableView.
 *
 *	@return	An object inheriting from UITableViewCell that the table view can use for the specified row.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView
		 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	ProductCell *cell					= [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
	
	IAPProduct *product					= self.products[indexPath.row];
	
	cell.mainLabel.text					= product.skProduct.localizedTitle;
	cell.detailLabel.text				= product.skProduct.localizedDescription;
	cell.iconView.image					= product.productInfo.icon;
	if (product.purchased)
		cell.priceLabel.text			= @"Purchased.";
	else
		cell.priceLabel.text			= [self.priceFormatter stringFromNumber:product.skProduct.price];
	
	return cell;
}

/**
 *	Asks the delegate for the height to use for a row in a specified location.
 *
 *	@param	tableView					The table-view object requesting this information.
 *	@param	indexPath					An index path that locates a row in tableView.
 *
 *	@return	A floating-point value that specifies the height (in points) that row should be.
 */
- (CGFloat)	  tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 96.0f;
}

/**
 *	Tells the data source to return the number of rows in a given section of a table view.
 *
 *	@param	tableView					The table-view object requesting this information.
 *	@param	section						An index number identifying a section in tableView.
 *
 *	@return	The number of rows in section.
 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
	return self.products.count;
}

#pragma mark - UITableViewDelegate Methods

/**
 *	Tells the delegate that the specified row is now selected.
 *
 *	@param	tableView					A table-view object informing the delegate about the new row selection.
 *	@param	indexPath					An index path locating the new selected row in tableView.
 */
- (void)	  tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	DetailViewController *detailVC		= [[DetailViewController alloc] init];
	detailVC.product					= self.products[indexPath.row];
	[self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark - View Lifecycle

/**
 *	Called after the controller’s view is loaded into memory.
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	BOOL proUpradePurchased				= [[NSUserDefaults standardUserDefaults] boolForKey:TestingProUpgradePurchased];
	if (proUpradePurchased)
		self.title						= @"To The Maximum PRO";
	else
		self.title						= @"To The Maximum";
	[self reload];
	[self.refreshControl beginRefreshing];
	
	UIBarButtonItem *restoreItem		= [[UIBarButtonItem alloc] initWithTitle:@"Restore" style:UIBarButtonItemStylePlain target:self action:@selector(restoreCompletedTransactions)];
	self.navigationItem.rightBarButtonItem	= restoreItem;
}

/**
 *	Notifies the view controller that its view is about to be added to a view hierarchy.
 *
 *	@param	animated					If YES, the view is being added to the window using an animation.
 */
- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	[[SpecificIAPHelper sharedInstance] addProductObserver:self];
}

/**
 *	Notifies the view controller that its view is about to be removed from a view hierarchy.
 *
 *	@param	animated					If YES, the disappearance of the view is being animated.
 */
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
	
	[[SpecificIAPHelper sharedInstance] removeProductObserver:self];
}

@end