//
//  IAPHelper.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPHelper.h"
#import "IAPProduct.h"

@import StoreKit;

#pragma mark - In-App Purchase Helper Private Class Extension

@interface IAPHelper () <SKProductsRequestDelegate> {}

#pragma mark - Private Properties

/**	The completion handler to call when a product request completes.	*/
@property (nonatomic, copy)	RequestProductsCompletionHandler		completionHandler;
/**	A mutable dictionary of the products currently in memory.	*/
@property (nonatomic, strong)	NSMutableDictionary					*internalProducts;
/**	An object used to keep any products request in memory.	*/
@property (nonatomic, strong)	SKProductsRequest					*productsRequest;

@end

#pragma mark - In-App Purchase Helper Implementation

@implementation IAPHelper {}

#pragma mark - IAP Product Management

/**
 *	Requests a in-app purchase product with the given product identifiers.
 *
 *	@param	completionHandler			Called when the request has completed.
 */
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler
{
	//	copy the block to make sure it is available when required even if passed in on stack
	self.completionHandler				= completionHandler;
	
	//	get a set of the product identifiers and set all of the products 'availableForPurchase' to NO
	NSSet *productIdentifiers			= [[NSSet alloc] initWithArray:[self.internalProducts allKeys]];
	[[self.internalProducts allValues] makeObjectsPerformSelector:@selector(setAvailableForPurchase:) withObject:@(NO)];
	
	//	create the products request with the product identifiers
	self.productsRequest				= [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
	self.productsRequest.delegate		= self;
	[self.productsRequest start];
}

#pragma mark - Initialisation

/**
 *	Initializes and returns a newly allocated IAPHelper with the allocated products.
 *
 *	@param	products					A dictionary of products.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProducts:(NSDictionary *)products
{
    if (self = [super init])
	{
		[self.internalProducts addEntriesFromDictionary:products];
    }
	
    return self;
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	A mutable dictionary of the products currently in memory.
 *
 *	@return	A mutable dictionary of the products currently in memory.
 */
- (NSMutableDictionary *)internalProducts
{
	//	lazy instantiation (so a nil dictionary is never returned)
	if (!_internalProducts)
		_internalProducts				= [[NSMutableDictionary alloc] init];
	
	return _internalProducts;
}

/**
 *	A dictionary of the products managed by this IAPHelper.
 *
 *	@return	A dictionary of the products managed by this IAPHelper.
 */
- (NSDictionary *)products
{
	//	return an immutable copy of the internal dictionary of products
	return [self.internalProducts copy];
}

#pragma mark - SKProductsRequestDelegate Methods

/**
 *	Called when the Apple App Store responds to the product request.
 *
 *	@param	request						The product request sent to the Apple App Store.
 *	@param	response					Detailed information about the list of products.
 */
- (void)productsRequest:(SKProductsRequest *)request
	 didReceiveResponse:(SKProductsResponse *)response
{
	//	the product request has completed and is now redundant
	self.productsRequest				= nil;
	
	//	loops through each product and marks the associated IAPProduct appropriately
	NSArray *skProducts					= response.products;
	for (SKProduct *skProduct in skProducts)
	{
		IAPProduct *product				= self.internalProducts[skProduct.productIdentifier];
		product.availableForPurchase	= YES;
		product.skProduct				= skProduct;
	}
	
	//	iterate through all of the product identifiers which are not valid
	for (NSString *invalidProductIdentifier in response.invalidProductIdentifiers)
	{
		IAPProduct *product				= self.internalProducts[invalidProductIdentifier];
		product.availableForPurchase	= NO;
	}
	
	//	get all of the available products and call the completion handler with them
	NSMutableArray *availableProducts	= [[NSMutableArray alloc] init];
	for (IAPProduct *product in [self.internalProducts allValues])
		if (product.availableForPurchase)
			[availableProducts addObject:product];
	
	self.completionHandler(YES, availableProducts);
	self.completionHandler				= nil;
}

/**
 *	Called if the request failed to execute.
 *
 *	@param	request						The request that failed.
 *	@param	error						The error that caused the request to fail.

 */
- (void) request:(SKRequest *)request
didFailWithError:(NSError *)error
{
	//	the product request has completed and is now redundant
	self.productsRequest				= nil;
	
	//	call the completion handler to inform of failure
	self.completionHandler(NO, nil);
	self.completionHandler				= nil;
}

@end