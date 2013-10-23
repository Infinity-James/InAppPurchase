//
//  IAPInfo.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 23/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPProductInfo.h"

#pragma mark - Constants & Static Variables

/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoBundleDirectoryKey		= @"bundleDirectory";
/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoConsumableAmountKey	= @"consumableAmount";
/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoConsumableIdentifierKey= @"consumableIdentifier";
/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoConsumableKey			= @"consumable";
/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoIconURLKey				= @"iconURL";
/**	The key to be used in an NSDictionary to extract the product identifier.	*/
static NSString *const IAPProductInfoProductIdentifierKey	= @"productIdentifier";

#pragma mark -  In-App Purchase Product Info Private Class Extension

@interface IAPProductInfo () {}

#pragma mark - Private Properties

/**	For a non-consumable product, this contains the directory where the content resides.	*/
@property (nonatomic, strong, readwrite)	NSString		*bundleDirectory;
/**	Where this a consumable or non-consumable in-app purchase.	*/
@property (nonatomic, assign, readwrite)	BOOL			consumable;
/**	The amount of the consumable object unlocked by this in-app purchase.	*/
@property (nonatomic, strong, readwrite)	NSNumber		*consumableAmount;
/**	If this is a consumable in-app purchase then this key is used in NSUserDefaults.	*/
@property (nonatomic, strong, readwrite)	NSString		*consumableIdentifier;
/**	The icon for the in-app purchase.	*/
@property (nonatomic, strong, readwrite)	UIImage			*icon;
/**	The URL of the icon for the in-app purchase.	*/
@property (nonatomic, strong)				NSString		*iconURL;
/**	The unique identifier for the IAPProduct.	*/
@property (nonatomic, strong, readwrite)	NSString		*productIdentifier;

@end

#pragma mark - In-App Purchase Product Info Implementation

@implementation IAPProductInfo {}

#pragma mark - Initialisation

/**
 *	Initializes and returns a newly allocated product info object from a dictionary containing the information of the product.
 *
 *	@param	dictionary					The dictionary containing the information for this IAPProductInfo.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initFromDictionary:(NSDictionary *)dictionary
{
    if (self = [super init])
	{
		self.bundleDirectory			= dictionary[IAPProductInfoBundleDirectoryKey];
		self.consumable					= [dictionary[IAPProductInfoConsumableKey] boolValue];
		self.consumableAmount			= dictionary[IAPProductInfoConsumableAmountKey];
		self.consumableIdentifier		= dictionary[IAPProductInfoConsumableIdentifierKey];
		self.iconURL					= dictionary[IAPProductInfoIconURLKey];
		self.productIdentifier			= dictionary[IAPProductInfoProductIdentifierKey];
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Setters

/**
 *	The URL of the icon for the in-app purchase.
 *
 *	@param	iconURL						The URL of the icon for the in-app purchase.
 */
- (void)setIconURL:(NSString *)iconURL
{
	if ([_iconURL isEqualToString:iconURL])
		return;
	
	_iconURL							= iconURL;
	
	if (!_iconURL)						return;
	
	//	fetches the actual image
	__weak IAPProductInfo *weakSelf		= self;
	NSOperationQueue *privateQueue		= [[NSOperationQueue alloc] init];
	privateQueue.name					= @"Product Info Icon Fetcher";
	[privateQueue addOperationWithBlock:
	^{
		NSData *iconData				= [[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:_iconURL]];
		weakSelf.icon					= [[UIImage alloc] initWithData:iconData];
	}];
}

@end