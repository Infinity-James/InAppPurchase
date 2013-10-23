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
@property (nonatomic, strong, readwrite)	NSString		*productIdentifier;

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
	return [self initWithProductIdentifier:productIdentifier andProductInfo:nil];
}

/**
 *	Initializes and returns a newly allocated product object with the specified product identifier.
 *
 *	@param	productIdentifier			The product identifier of this product
 *	@param	productInfo					The information for this IAPProduct.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier
						   andProductInfo:(IAPProductInfo *)productInfo
{
    if (self = [super init])
	{
		self.availableForPurchase		= NO;
		self.productIdentifier			= productIdentifier;
		self.productInfo				= productInfo;
		self.skProduct					= nil;
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
	BOOL purchased						= (!self.productInfo.consumable && self.purchaseDetails);
	
	//	it needs to be available, not currently being purchased, needs to have info, and it can't have been purchased
	return (self.availableForPurchase && !self.purchaseInProgress && self.productInfo && !purchased);
}

@end
