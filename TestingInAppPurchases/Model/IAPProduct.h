//
//  IAPProduct.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

//	import the iapproduct info because all objects that know about IAPProduct should know about IAPProductInfo
#import "IAPProductInfo.h"
#import "IAPProductPurchaseDetails.h"

@class SKProduct;

#pragma mark - IAP Product Public Interface

@interface IAPProduct : NSObject {}

#pragma mark - Public Properties

/**	Whether or not the user is allowed to purchase this item.	*/
@property (nonatomic, assign, readonly)		BOOL						allowedToPurchase;
/**	Whether or not this procudt is available for purchase.	*/
@property (nonatomic, assign)				BOOL						availableForPurchase;
/**	The identifier of this product	*/
@property (nonatomic, strong, readonly)		NSString					*productIdentifier;
/**	The information for this product.	*/
@property (nonatomic, strong)				IAPProductInfo				*productInfo;
/**	Whether or not this product has already been purchased.	*/
@property (nonatomic, assign)				IAPProductPurchaseDetails	*purchaseDetails;
/**	Whether or not this product is currently being purchased.	*/
@property (nonatomic, assign)				BOOL						purchaseInProgress;
/**	The StoreKit Product object associated with this product.	*/
@property (nonatomic, strong)				SKProduct					*skProduct;

#pragma mark - Public Methods

/**
 *	Initializes and returns a newly allocated product object with the specified product identifier.
 *
 *	@param	productIdentifier			The identifier of this product
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier;
/**
 *	Initializes and returns a newly allocated product object with the specified product identifier.
 *
 *	@param	productIdentifier			The product identifier of this product
 *	@param	productInfo					The information for this IAPProduct.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProductIdentifier:(NSString *)productIdentifier
						   andProductInfo:(IAPProductInfo *)productInfo;

@end