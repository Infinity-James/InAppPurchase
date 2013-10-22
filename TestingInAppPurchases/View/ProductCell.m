//
//  ProductCell.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "ProductCell.h"

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
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier])
	{
		self.accessoryView				= self.priceLabel;
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	A label displaying the price of the product.
 *
 *	@return	A label displaying the price of the product.
 */
- (UILabel *)priceLabel
{
	if (!_priceLabel)
	{
		CGSize labelSize				= CGSizeMake(64.0f, self.contentView.bounds.size.height);
		_priceLabel						= [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width - labelSize.width, 0.0f,
																					labelSize.width, labelSize.height)];
		_priceLabel.textAlignment		= NSTextAlignmentCenter;
		[self.contentView addSubview:_priceLabel];
	}
	
	return _priceLabel;
}

@end