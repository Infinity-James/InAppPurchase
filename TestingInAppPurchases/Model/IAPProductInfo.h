//
//  IAPInfo.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 23/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - In-App Purchase Product Info Public Interface

@interface IAPProductInfo : NSObject {}

#pragma mark - Public Properties

/**	For a non-consumable product, this contains the directory where the content resides.	*/
@property (nonatomic, strong, readonly)		NSString		*bundleDirectory;
/**	Where this a consumable or non-consumable in-app purchase.	*/
@property (nonatomic, assign, readonly)		BOOL			consumable;
/**	The amount of the consumable object unlocked by this in-app purchase.	*/
@property (nonatomic, strong, readonly)		NSNumber		*consumableAmount;
/**	If this is a consumable in-app purchase then this key is used in NSUserDefaults.	*/
@property (nonatomic, strong, readonly)		NSString		*consumableIdentifier;
/**	The icon for the in-app purchase.	*/
@property (nonatomic, strong, readonly)		UIImage			*icon;
/**	The unique identifier for the IAPProduct.	*/
@property (nonatomic, strong, readonly)		NSString		*productIdentifier;

#pragma mark - Public Methods

/**
 *	Initializes and returns a newly allocated product info object from a dictionary containing the information of the product.
 *
 *	@param	dictionary					The dictionary containing the information for this IAPProductInfo.
 *
 *	@return	An initialized view object or nil if the object couldn't be created.
 */
- (instancetype)initFromDictionary:(NSDictionary *)dictionary;

@end