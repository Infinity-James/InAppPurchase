//
//  IAPProductPurchaseDetails.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 23/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPProductPurchaseDetails.h"

#pragma mark - Constants & Static Variables

/**	The key for the product identifier.	*/
static NSString *const IAPProductPurchaseDetailsConsumableKey			= @"consumable";
/**	The key for the product identifier.	*/
static NSString *const IAPProductPurchaseDetailsContentVersionKey		= @"contentVersion";
/**	The key for the product identifier.	*/
static NSString *const IAPProductPurchaseDetailsLibraryRelativePathKey	= @"libraryRelativePath";
/**	The key for the product identifier.	*/
static NSString *const IAPProductPurchaseDetailsProductIdentifierKey	= @"productIdentifier";
/**	The key for the product identifier.	*/
static NSString *const IAPProductPurchaseDetailsTimesPurchasedKey		= @"timesPurchased";

#pragma mark - In-App Purchase Product Purchase Details Private Class Extension

@interface IAPProductPurchaseDetails () {}

#pragma mark - Private Properties

/**	The identifier of this in-app purchase.	*/
@property (nonatomic, strong, readwrite)	NSString	*productIdentifier;

@end

#pragma mark - In-App Purchase Product Purchase Details Implementation

@implementation IAPProductPurchaseDetails {}

#pragma mark - Initialisation

/**
 *	Implemented by subclasses to initialize a new purchase details object.
 *
 *	@param	productIdentifier			The identifier of this in-app purchase.
 *	@param	consumable					Whether or not this in-app purchase is consumable or non-consumable.
 *	@param	timesPurchased				If the IAPProduct is consumable, this is the amount of times it has been purchased.
 *	@param	libraryRelativePath
 *	@param	contentVersion				The version number of this in-app purchase content.
 *
 *	@return	An initialized object.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier
							   consumable:(BOOL)consumable
						   timesPurchased:(NSUInteger)timesPurchased
					  libraryRelativePath:(NSString *)libraryRelativePath
						   contentVersion:(NSString *)contentVersion
{
	if (self = [super init])
	{
		self.consumable					= consumable;
		self.contentVersion				= contentVersion;
		self.libraryRelativePath		= libraryRelativePath;
		self.productIdentifier			= productIdentifier;
		self.timesPurchased				= timesPurchased;
	}
	
	return self;
}

#pragma mark - NSCoding Methods

/**
 *	Encodes the receiver using a given archiver.
 *
 *	@param	aCoder						An archiver object.
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeBool:self.consumable forKey:IAPProductPurchaseDetailsConsumableKey];
	[aCoder encodeObject:self.contentVersion forKey:IAPProductPurchaseDetailsContentVersionKey];
	[aCoder encodeObject:self.libraryRelativePath forKey:IAPProductPurchaseDetailsLibraryRelativePathKey];
	[aCoder encodeObject:self.productIdentifier forKey:IAPProductPurchaseDetailsProductIdentifierKey];
	[aCoder encodeInteger:self.timesPurchased forKey:IAPProductPurchaseDetailsTimesPurchasedKey];
}

/**
 *	Returns an object initialized from data in a given unarchiver.
 *
 *	@param	aDecoder					An unarchiver object.
 *
 *	@return	self, initialized using the data in decoder.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	BOOL consumable						= [aDecoder decodeBoolForKey:IAPProductPurchaseDetailsConsumableKey];
	NSString *contentVersion			= [aDecoder decodeObjectForKey:IAPProductPurchaseDetailsContentVersionKey];
	NSString *libraryRelativePath		= [aDecoder decodeObjectForKey:IAPProductPurchaseDetailsLibraryRelativePathKey];
	NSString *productIdentifier			= [aDecoder decodeObjectForKey:IAPProductPurchaseDetailsProductIdentifierKey];
	NSUInteger timesPurchased			= [aDecoder decodeIntegerForKey:IAPProductPurchaseDetailsTimesPurchasedKey];
	
	return [self initWithProductIdentifier:productIdentifier
								consumable:consumable
							timesPurchased:timesPurchased
					   libraryRelativePath:libraryRelativePath
							contentVersion:contentVersion];
}

@end