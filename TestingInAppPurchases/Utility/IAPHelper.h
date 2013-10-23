//
//  IAPHelper.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

@class IAPProduct;

#pragma mark - Type Definitions

/**	A block called once a request for products has completed.	*/
typedef void(^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

/**		*/
typedef NS_OPTIONS(NSUInteger, IAPHelperProductStatusUpdate)
{
	IAPProductStatusUpdatePurchased				= 1 << 0,
	IAPProductStatusUpdatePurchaseInProgress	= 1 << 1
};

#pragma mark - IAPHelper Product Observer Declaration

@protocol IAPHelperProductObserver <NSObject>

#pragma mark - Required Methods

@required

/**
 *	Sent to an observer when a product has updated.
 *
 *	@param	product						The product which has been updated in some way.
 */
- (void)product:(IAPProduct *)product updatedWithStatus:(IAPHelperProductStatusUpdate)statusUpdate;

@end

#pragma mark - In-App Purchase Helper Public Interface

@interface IAPHelper : Singleton {}

#pragma mark - Public Properties

/**	A dictionary of the products managed by this IAPHelper.	*/
@property (nonatomic, strong, readonly)		NSDictionary	*products;

#pragma mark - Public Methods

/**
 *	Adds an observer of the products being handled by this IAPHelper.
 *
 *	@param	observer					The object that wants to be updated by a change in a product's state.
 */
- (void)addProductObserver:(id <IAPHelperProductObserver>)observer;
/**
 *	Purchases the passed in product.
 *
 *	@param	product						The IAPProduct to purchase.
 */
- (void)buyProduct:(IAPProduct *)product;
/**
 *	Initializes and returns a newly allocated IAPHelper with the allocated products.
 *
 *	@param	productInfoURL				The URL for the .plist file containing the in-app purchase product information.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductInfoURL:(NSURL *)productInfoURL;
/**
 *	Removes an observer from product updates.
 *
 *	@param	observer					The object to remove from product status updates.
 */
- (void)removeProductObserver:(id <IAPHelperProductObserver>)observer;
/**
 *	Requests a in-app purchase product with the given product identifiers.
 *
 *	@param	completionHandler			Called when the request has completed.
 */
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;
/**
 *	Restores all previously completed transactions.
 */
- (void)restoreCompletedTransactions;

#pragma mark - Virtual Methods

/**
 *	Provides the content at the URL for the product identifier.
 *
 *	@param	url							The URL of the file for the unlocked non-consumable in-app purchase.
 *	@param	productIdentifier			The product identifier relating to the product for which to provide the appropriate content.
 */
- (void)provideContentAtURL:(NSURL *)url
	   forProductIdentifier:(NSString *)productIdentifier;
/**
 *	Notifies the user of the status of a given product.
 *
 *	@param	status						The status to display to the user.
 *	@param	product						The product for which the update pertains to.
 */
- (void)notifyStatus:(NSString *)status forProduct:(IAPProduct *)product;

@end