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
@property (nonatomic, strong)		UITextView				*descriptionTextView;
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

/**
 *	Called when the view controller’s view needs to update its constraints.
 */
- (void)updateViewConstraints
{
	[super updateViewConstraints];
	
	//	remove all constraints
	[self.view removeConstraints:self.view.constraints];
	
	//	create the dictionary of views
	NSDictionary *viewsDictionary	= @{@"cancelButton"		: self.cancelButton,
										@"pauseButton"		: self.pauseButton,
										@"resumeButton"		: self.resumeButton,
										@"descriptonView"	: self.descriptionTextView,
										@"priceLabel"		: self.priceLabel,
										@"titleLabel"		: self.titleLabel,
										@"top"				: self.topLayoutGuide,
										@"versionLabel"		: self.versionLabel};
	
	//	centre and position the title
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.titleLabel
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterX
														 multiplier:1.0f
														   constant:0.0f]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[top][titleLabel][versionLabel]"
																	  options:kNilOptions
																	  metrics:nil
																		views:viewsDictionary]];
	
	//	vertically lay out the rest of the views
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[versionLabel]"
																	  options:kNilOptions
																	  metrics:nil
																		views:viewsDictionary]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[versionLabel]-[priceLabel]-[descriptionView(128)]"
																	  options:NSLayoutFormatAlignAllLeading
																	  metrics:nil
																		views:viewsDictionary]];
	//	align the buttons and lay them out horizontally
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[resumeButton]-|"
																	  options:kNilOptions
																	  metrics:nil
																		views:viewsDictionary]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.pauseButton
														  attribute:NSLayoutAttributeCenterX
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeCenterX
														 multiplier:1.0f
														   constant:0.0f]];
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[resumeButton]-[pauseButton]-[cancelButton]"
																	  options:NSLayoutFormatAlignAllCenterY
																	  metrics:nil
																		views:viewsDictionary]];
}

#pragma mark - Initialisation

/**
 *	Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
 *
 *	@return	An initialized object.
 */
- (instancetype)init
{
	if (self = [super init])
	{
	}
	
	return self;
}

/**
 *	Initialise all subviews.
 */
- (void)initialiseSubviews
{
	//	initialise the buttons
	self.cancelButton					= [[UIButton alloc] init];
	self.pauseButton					= [[UIButton alloc] init];
	self.resumeButton					= [[UIButton alloc] init];
	
	//	configure the buttons
	[self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
	[self.pauseButton setTitle:@"Pause" forState:UIControlStateNormal];
	[self.resumeButton setTitle:@"Resume" forState:UIControlStateNormal];
	[self.cancelButton addTarget:self action:@selector(cancelTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.pauseButton addTarget:self action:@selector(pauseTapped:) forControlEvents:UIControlEventTouchUpInside];
	[self.resumeButton addTarget:self action:@selector(resumeTapped:) forControlEvents:UIControlEventTouchUpInside];
	
	//	initialise the labels
	self.descriptionTextView			= [[UITextView alloc] init];
	self.priceLabel						= [[UILabel alloc] init];
	self.titleLabel						= [[UILabel alloc] init];
	self.versionLabel					= [[UILabel alloc] init];
	
	//	configure the labels
	self.titleLabel.textAlignment		= NSTextAlignmentCenter;
}

#pragma mark - Product Purchasing

/**
 *	The buy button has been tapped.
 *
 *	@param	buyItem						The button tapped indicated users intent to purchase the product.
 */
- (void)buyTapped:(UIBarButtonItem *)buyItem
{
	
}

/**
 *	The user wants to cancel the purchase in progress.
 *
 *	@param	cancelButton				The button tapped.
 */
- (void)cancelTapped:(UIButton *)cancelButton
{
	
}

/**
 *	The user wants to pause the purchase in progress.
 *
 *	@param	pauseButton				The button tapped.
 */
- (void)pauseTapped:(UIButton *)pauseButton
{
	
}

/**
 *	The user wants to resume the cancelled purchase.
 *
 *	@param	resumeButton				The button tapped.
 */
- (void)resumeTapped:(UIButton *)resumeButton
{
	
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

#pragma mark - Subview Management

/**
 *	Adds all of the subviews for auto layout.
 */
- (void)addAllSubviews
{
	//	add the buttons
	[self.view addSubviewForAutoLayout:self.cancelButton];
	[self.view addSubviewForAutoLayout:self.pauseButton];
	[self.view addSubviewForAutoLayout:self.resumeButton];
	
	//	add the labels
	[self.view addSubviewForAutoLayout:self.descriptionTextView];
	[self.view addSubviewForAutoLayout:self.priceLabel];
	[self.view addSubviewForAutoLayout:self.titleLabel];
	[self.view addSubviewForAutoLayout:self.versionLabel];
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

#pragma mark - View Lifecycle

/**
 *	Called after the controller’s view is loaded into memory.
 */
- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.view.backgroundColor			= [[UIColor alloc] initWithRed:165.0f / 255.0f green:165.0f / 255.0f blue:165.0f / 255.0f alpha:1.0f];
	//	add the subviews and trigger layout
	[self addAllSubviews];
	[self.view setNeedsUpdateConstraints];
}

@end