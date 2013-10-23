//
//  ProductCell.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "ProductCell.h"

#pragma mark - Product Cell Private Class Extension

@interface ProductCell () {}

#pragma mark - Private Properties

/**	The detail subtitle label.	*/
@property (nonatomic, strong, readwrite)	UILabel		*detailLabel;
/**	A view to display the icon of the product.	*/
@property (nonatomic, strong, readwrite)	UIImageView	*iconView;
/**	The main title label.	*/
@property (nonatomic, strong, readwrite)	UILabel		*mainLabel;
/**	A label displaying the price of the product.	*/
@property (nonatomic, strong, readwrite)	UILabel		*priceLabel;

@end

#pragma mark - Product Cell Implementation

@implementation ProductCell

#pragma mark - Initialisation

/**
 *	Initializes a table cell with a style and a reuse identifier and returns it to the caller.
 *
 *	@param	style						A constant indicating a cell style.
 *	@param	reuseIdentifier				A string used to identify the cell object if it is to be reused for drawing multiple rows of a table view.
 *
 *	@return	An initialized UITableViewCell object or nil if the object could not be created.
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
			  reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *
 *
 *	@return
 */
- (UILabel *)detailLabel
{
	if (!_detailLabel)
	{
		CGSize labelSize				= CGSizeMake(196.0f, self.contentView.bounds.size.height / 2.0f);
		_detailLabel					= [[UILabel alloc] initWithFrame:CGRectMake(96.0f, self.bounds.size.height / 2.0f,
																					labelSize.width, labelSize.height)];
		_detailLabel.font				= [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
		
		[self.contentView addSubview:_detailLabel];
	}
	
	return _detailLabel;
}

/**
 *
 *
 *	@return
 */
- (UIImageView *)iconView
{
	if (!_iconView)
	{
		CGSize labelSize				= CGSizeMake(64.0f, 64.0f);
		_iconView						= [[UIImageView alloc] initWithFrame:CGRectMake(10.0f,
																						(self.bounds.size.height - labelSize.height) / 2.0f,
																						labelSize.width, labelSize.height)];
		_iconView.contentMode			= UIViewContentModeScaleAspectFit;
		[self.contentView addSubview:_iconView];
	}
	
	return _iconView;
}

/**
 *
 *
 *	@return
 */
- (UILabel *)mainLabel
{
	if (!_mainLabel)
	{
		CGSize labelSize				= CGSizeMake(196.0f, self.contentView.bounds.size.height / 2.0f);
		_mainLabel						= [[UILabel alloc] initWithFrame:CGRectMake(96.0f, 0.0f,
																					labelSize.width, labelSize.height)];
		_mainLabel.font					= [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
		[self.contentView addSubview:_mainLabel];
	}
	
	return _mainLabel;
}

/**
 *	A label displaying the price of the product.
 *
 *	@return	A label displaying the price of the product.
 */
- (UILabel *)priceLabel
{
	if (!_priceLabel)
	{
		CGSize labelSize				= CGSizeMake(128.0f, self.contentView.bounds.size.height);
		_priceLabel						= [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - labelSize.width, 0.0f,
																					labelSize.width, labelSize.height)];
		_priceLabel.font				= [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		_priceLabel.textAlignment		= NSTextAlignmentRight;
		[self.contentView addSubview:_priceLabel];
	}
	
	return _priceLabel;
}

#pragma mark - UIView Methods

#pragma mark - View-Related Observation Methods

/**
 *	Tells the view that its superview changed.
 */
- (void)didMoveToSuperview
{
	[super didMoveToSuperview];
	
	[self detailLabel];
	[self iconView];
	[self mainLabel];
	[self priceLabel];
}

@end