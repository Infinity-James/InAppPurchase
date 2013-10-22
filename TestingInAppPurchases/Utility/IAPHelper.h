//
//  IAPHelper.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - Type Definitions

/**	A block called once a request for products has completed.	*/
typedef void(^RequestProductsCompletionHandler)(BOOL success, NSArray *products);

#pragma mark - In-App Purchase Helper Public Interface

@interface IAPHelper : Singleton {}

#pragma mark - Public Properties

/**	A dictionary of the products managed by this IAPHelper.	*/
@property (nonatomic, strong, readonly)		NSDictionary	*products;

#pragma mark - Public Methods

/**
 *	Initializes and returns a newly allocated IAPHelper with the allocated products.
 *
 *	@param	products					A dictionary of products.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initWithProducts:(NSDictionary *)products;
/**
 *	Requests a in-app purchase product with the given product identifiers.
 *
 *	@param	completionHandler			Called when the request has completed.
 */
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end