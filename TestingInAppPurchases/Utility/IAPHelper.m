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

@interface IAPHelper () <SKPaymentTransactionObserver, SKProductsRequestDelegate> {}

#pragma mark - Private Properties

/**	The completion handler to call when a product request completes.	*/
@property (nonatomic, copy)	RequestProductsCompletionHandler		completionHandler;
/**	An array of objects that want to be updated on product updates.	*/
@property (nonatomic, strong)				NSMutableArray			*observers;
/**	A dictionary of the products managed by this IAPHelper.	*/
@property (nonatomic, strong)				NSMutableDictionary		*internalProducts;
/**	An object used to keep any products request in memory.	*/
@property (nonatomic, strong)				SKProductsRequest		*productsRequest;

@end

#pragma mark - In-App Purchase Helper Implementation

@implementation IAPHelper {}

#pragma mark - Content Distribution

/**
 *	Provides the content at the URL for the product identifier.
 *
 *	@param	url							The URL of the file for the unlocked non-consumable in-app purchase.
 *	@param	productIdentifier			The product identifier relating to the product for which to provide the appropriate content.
 */
- (void)provideContentAtURL:(NSURL *)url
	   forProductIdentifier:(NSString *)productIdentifier
{
	NSLog(@"This method (%@) should be overridden by the the subclass of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

/**
 *	Provides the purchased content for the given completed transaction.
 *
 *	@param	transaction					The completed SKPaymentTransactionf or which to provide content.
 *	@param	productIdentifier			The product identifier of the product purchased.
 */
- (void)provideContentForCompletedTransaction:(SKPaymentTransaction *)transaction
							productIdentifier:(NSString *)productIdentifier
{
	//	get the product that completed and update with the completed status
	IAPProduct *product					= self.internalProducts[productIdentifier];
	
	//	if the object is consumable we use it appropriately
	if (product.productInfo.consumable)
		;
	//	otherwise we download the non-consumable file
	else
		;
	
	[self notifyStatus:@"Purchase completed." forProduct:product];
	
	//	finish the transaction
	product.purchaseInProgress			= NO;
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
	
	//	update observers about the change in the product
	[self.observers makeObjectsPerformSelector:@selector(product:updatedWithStatus:)
									withObject:product
									withObject:@(IAPProductStatusUpdatePurchased | IAPProductStatusUpdatePurchaseInProgress)];
}

/**
 *	Unlocks the consumable item for the given identifier and with the given amount.
 *
 *	@param	consumableIdentifier		The identifier of the consumable item to unlock.
 *	@param	consumableAmount			The amount of the consumable item purchased.
 *	@param	productIdentifier			The product identifier for the consumable in-app purchase.
 */
- (void)unlockConsumable:(NSString *)consumableIdentifier
			  withAmount:(NSNumber *)consumableAmount
	forProductIdentifier:(NSString *)productIdentifier
{
	//	calculate new amount for consumable item
	NSNumber *previousAmount			= [[NSUserDefaults standardUserDefaults] objectForKey:consumableIdentifier];
	NSNumber *newAmount					= [[NSNumber alloc] initWithFloat:([previousAmount floatValue] + [consumableAmount floatValue])];
	
	//	save the new amount to NSUserDefaults
	[[NSUserDefaults standardUserDefaults] setObject:newAmount forKey:consumableIdentifier];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 *	Unlocks the non-consumable item permanently and downloads the associated URL.
 *
 *	@param	url							The URL of the file for the unlocked non-consumable in-app purchase.
 *	@param	productIdentifier			The product identifier for the non-consumable in-app purchase.
 */
- (void)unlockNonConsumableAtURL:(NSURL *)url
			forProductIdentifier:(NSString *)productIdentifier
{
	[self provideContentAtURL:url forProductIdentifier:productIdentifier];
}

#pragma mark - IAP Product Management

/**
 *	Adds an IAPProduct with the given information and product identifier.
 *
 *	@param	productInfo					The IAPProductInfo object containing the information for the product to add.
 *	@param	productIdentifier			The unique identifier for the product to add.
 */
- (void)addProductWithInfo:(IAPProductInfo *)productInfo
	  andProductIdentifier:(NSString *)productIdentifier
{
	IAPProduct *product					= self.internalProducts[productIdentifier];
	
	if (!product)
		self.internalProducts[productIdentifier]= [[IAPProduct alloc] initWithProductIdentifier:productIdentifier
																				 andProductInfo:productInfo];
	else
		product.productInfo				= productInfo;
}

/**
 *	Purchases the passed in product.
 *
 *	@param	product						The IAPProduct to purchase.
 */
- (void)buyProduct:(IAPProduct *)product
{
	NSAssert(product.allowedToPurchase, @"This product cannot be purchased.");
	
	product.purchaseInProgress			= YES;
	
	//	issues a payment to the payment queue for this product
	SKPayment *payment					= [SKPayment paymentWithProduct:product.skProduct];
	[[SKPaymentQueue defaultQueue] addPayment:payment];
	
	//	update observers about the change in the product
	[self.observers makeObjectsPerformSelector:@selector(product:updatedWithStatus:)
									withObject:product
									withObject:@(IAPProductStatusUpdatePurchaseInProgress)];
}

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
 *	@param	productInfoURL				The URL for the .plist file containing the in-app purchase product information.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductInfoURL:(NSURL *)productInfoURL
{
    if (self = [super init])
	{
		NSArray *productInfos			= [[NSArray alloc] initWithContentsOfURL:productInfoURL];
		for (NSDictionary *productInfoDictionary in productInfos)
		{
			IAPProductInfo *productInfo	= [[IAPProductInfo alloc] initFromDictionary:productInfoDictionary];
			[self addProductWithInfo:productInfo andProductIdentifier:productInfo.productIdentifier];
		}
		
		[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    }
	
    return self;
}

#pragma mark - Observer Methods

/**
 *	Adds an observer of the products being handled by this IAPHelper.
 *
 *	@param	observer					The object that wants to be updated by a change in a product's state.
 */
- (void)addProductObserver:(id <IAPHelperProductObserver>)observer
{
	[self.observers addObject:observer];
}

/**
 *	Removes an observer from product updates.
 *
 *	@param	observer					The object to remove from product status updates.
 */
- (void)removeProductObserver:(id <IAPHelperProductObserver>)observer
{
	[self.observers removeObject:observer];
}

#pragma mark - Payment Transaction Management

/**
 *	Handles the completion of the given transaction.
 *
 *	@param	transaction					The SKPaymentTransaction to complete.
 */
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
	[self provideContentForCompletedTransaction:transaction
							  productIdentifier:transaction.payment.productIdentifier];
}

/**
 *	Handles a transaction which has failed.
 *
 *	@param	transaction					The SKPaymentTransaction which failed.
 */
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
	IAPProduct *product					= self.internalProducts[transaction.payment.productIdentifier];
	[self notifyStatus:@"Purchase failed." forProductIdentifier:transaction.payment.productIdentifier];
	product.purchaseInProgress			= NO;
	
	//	finish the transaction
	[[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

/**
 *	Restores all previously completed transactions.
 */
- (void)restoreCompletedTransactions
{
	[[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

/**
 *	Handles the restoration of the given transaction.
 *
 *	@param	transaction					The SKPaymentTransaction to restore.
 */
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
	[self provideContentForCompletedTransaction:transaction
							  productIdentifier:transaction.originalTransaction.payment.productIdentifier];
}

#pragma mark - Property Accessor Methods - Getters

/**
 *	A dictionary of the products managed by this IAPHelper.
 *
 *	@return	A dictionary of the products managed by this IAPHelper.
 */
- (NSMutableDictionary *)internalProducts
{
	if (!_internalProducts)
		_internalProducts				= [[NSMutableDictionary alloc] init];
	
	return _internalProducts;
}

/**
 *	An array of objects that want to be updated on product updates.
 *
 *	@return	An array of objects that want to be updated on product updates.
 */
- (NSMutableArray *)observers
{
	//	lazy instantiation to make sure a nil array is never returned
	if (!_observers)
		_observers						= [[NSMutableArray alloc] init];
	
	return _observers;
}

/**
 *	A dictionary of the products managed by this IAPHelper.
 *
 *	@return	A dictionary of the products managed by this IAPHelper.
 */
- (NSDictionary *)products
{
	return [self.internalProducts copy];
}

#pragma mark - SKPaymentTransactionObserver Methods

/**
 *	Tells an observer that one or more transactions have been updated.
 *
 *	@param	queue						The payment queue that updated the transactions.
 *	@param	transactions				An array of the transactions that were updated.
 */
- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions)
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStateFailed:
				[self failedTransaction:transaction];
				break;
			case SKPaymentTransactionStatePurchased:
				[self completeTransaction:transaction];
				break;
			case SKPaymentTransactionStatePurchasing:
				break;
			case SKPaymentTransactionStateRestored:
				[self restoreTransaction:transaction];
				break;
		}
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

#pragma mark - Status Updating Methods

/**
 *	Notifies the user of the status of the product with the given product identifier.
 *
 *	@param	status						The status to display to the user.
 *	@param	productIdentifier			The ID of the product for which the update pertains to.
 */
- (void)notifyStatus:(NSString *)status forProductIdentifier:(NSString *)productIdentifier
{
	IAPProduct *product					= self.internalProducts[productIdentifier];
	[self notifyStatus:status forProduct:product];
}

/**
 *	Notifies the user of the status of a given product.
 *
 *	@param	status						The status to display to the user.
 *	@param	product						The product for which the update pertains to.
 */
- (void)notifyStatus:(NSString *)status forProduct:(IAPProduct *)product
{
	NSLog(@"This method (%@) should be overridden by the the subclass of %@.", NSStringFromSelector(_cmd), NSStringFromClass([self class]));
}

@end