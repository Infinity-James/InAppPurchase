//
//  IAPProduct.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPProduct.h"

@import StoreKit;

#pragma mark - IAP Product Private Class Extension

@interface IAPProduct () {}

#pragma mark - Private Properties

/**	The identifier of this product	*/
@property (nonatomic, strong, readwrite)		NSString	*productIdentifier;

@end

#pragma mark - IAP Product Implementation

@implementation IAPProduct {}

#pragma mark - Initialisation

/**
 *	Initializes and returns a newly allocated product object with the specified product identifier.
 *
 *	@param	productIdentifier			The identifier of this product
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier
{
	return [self initWithProductIdentifier:productIdentifier andSKProduct:nil];
}

/**
 *	Initializes and returns a newly allocated product object with the specified product identifier.
 *
 *	@param	productIdentifier			The identifier of this product
 *	@param	skProduct					The SKProduct associated with this IAPProduct.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier
							 andSKProduct:(SKProduct *)skProduct
{
    if (self = [super init])
	{
		self.availableForPurchase		= NO;
		self.productIdentifier			= productIdentifier;
		self.skProduct					= skProduct;
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	Whether or not the user is allowed to purchase this item.
 *
 *	@return	Whether or not the user is allowed to purchase this item.
 */
- (BOOL)allowedToPurchase
{
	return self.availableForPurchase;
}

@end
