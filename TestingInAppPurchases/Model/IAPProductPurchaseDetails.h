//
//  IAPProductPurchaseDetails.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 23/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - In-App Purchase Product Purchase Details Public Interface

@interface IAPProductPurchaseDetails : NSObject <NSCoding> {}

#pragma mark - Public Properties

/**	Whether or not this in-app purchase is consumable or non-consumable.	*/
@property (nonatomic, assign)				BOOL		consumable;
/**	The version number of this in-app purchase content.	*/
@property (nonatomic, strong)				NSString	*contentVersion;
/**		*/
@property (nonatomic, strong)				NSString	*libraryRelativePath;
/**	The identifier of this in-app purchase.	*/
@property (nonatomic, strong, readonly)		NSString	*productIdentifier;
/**	If the IAPProduct is consumable, this is the amount of times it has been purchased.	*/
@property (nonatomic, assign)				NSUInteger	timesPurchased;

#pragma mark - Public Methods



@end