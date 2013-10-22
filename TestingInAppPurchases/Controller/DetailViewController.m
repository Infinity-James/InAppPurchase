//
//  DetailViewController.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 22/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "DetailViewController.h"
#import "IAPProduct.h"

@import StoreKit;

#pragma mark - Detail View Controller Private Class Extension

@interface DetailViewController () {}

#pragma mark - Private Properties - Buttons

/**	A button unsed to cancel a purchase in progress.	*/
@property (nonatomic, strong)		UIButton				*cancelButton;
/**	A button used to pause a purchase in progress.	*/
@property (nonatomic, strong)		UIButton				*pauseButton;
/**	A button used to resume a paused purchase.	*/
@property (nonatomic, strong)		UIButton				*resumeButton;

#pragma mark - Private Properties - Labels

/**	The description of the product.	*/
@property (nonatomic, strong)		UILabel					*descriptionTextView;
/**	A label displaying the price of the product.	 */
@property (nonatomic, strong)		UILabel					*priceLabel;
/**	The title of the product.	*/
@property (nonatomic, strong)		UILabel					*titleLabel;
/**	The version of hte product.	*/
@property (nonatomic, strong)		UILabel					*versionLabel;

#pragma mark - Private Properties - Objects

/**	A price formatter to use when displaying the price of the current product.	*/
@property (nonatomic, strong)		NSNumberFormatter		*priceFormatter;

@end

#pragma mark - Detail View Controller Implementation

@implementation DetailViewController {}

#pragma mark - Product Management

/**
 *	The buy button has been tapped.
 *
 *	@param	buyItem						The button tapped indicated users intent to purchase the product.
 */
- (void)buyTapped:(UIBarButtonItem *)buyItem
{
	
}

/**
 *	Refreshed the currently displayed product.
 */
- (void)refresh
{
	self.title							= self.product.skProduct.localizedTitle;
	self.titleLabel.text				= self.product.skProduct.localizedTitle;
	self.descriptionTextView.text		= self.product.skProduct.localizedDescription;
	[self.priceFormatter setLocale:self.product.skProduct.priceLocale];
	self.priceLabel.text				= [self.priceFormatter stringFromNumber:self.product.skProduct.price];
	self.versionLabel.text				= @"Version 1.0";
	
	if (self.product.allowedToPurchase)
	{
		self.navigationItem.rightBarButtonItem	= [[UIBarButtonItem alloc] initWithTitle:@"Buy"
																				  style:UIBarButtonItemStyleBordered
																				 target:self
																				 action:@selector(buyTapped:)];
		self.navigationItem.rightBarButtonItem.enabled	= YES;
	}
	else
		self.navigationItem.rightBarButtonItem	= nil;
	
	
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

#pragma mark - View Lifecycle

/**
 *	Called after the controller’s view is loaded into memory.
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor			= [[UIColor alloc] initWithRed:165.0f / 255.0f green:165.0f / 255.0f blue:165.0f / 255.0f alpha:1.0f];
	
}

@end