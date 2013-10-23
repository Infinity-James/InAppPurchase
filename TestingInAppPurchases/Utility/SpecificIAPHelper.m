//
//  SpecificIAPHelper.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPProduct.h"
#import "SpecificIAPHelper.h"

@import StoreKit;

#pragma mark - Specific In-App Purchase Helper Implementation

@implementation SpecificIAPHelper {}

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
	if ([productIdentifier rangeOfString:@"upgrade"].location != NSNotFound)
	{
		[[NSUserDefaults standardUserDefaults] setBool:YES forKey:[url absoluteString]];
		[[NSUserDefaults standardUserDefaults] synchronize];
	}
}


/**
 *	Unlocks the upgrade for the given product identifier.
 *
 *	@param	productIdentifier			The product identifier for the upgrade to unlock.
 */
- (void)unlockUpgradeWithProductIdentifier:(NSString *)productIdentifier
{
	//	update the product to note that it has been purchased
	IAPProduct *product					= self.products[productIdentifier];
	product.purchased					= YES;
	
	//	save the fact that this has been bought
	[[NSUserDefaults standardUserDefaults] setBool:YES forKey:TestingProUpgradePurchased];
	[[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - Initialisation

/**
 *	Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
 *
 *	@return	An initialized object.
 */
- (instancetype)init
{
	if (self = [super initWithProductInfoURL:[[NSBundle mainBundle] URLForResource:@"productInfos" withExtension:@"plist"]])
	{
			
	}
	
	return self;
}

#pragma mark - Status Updating Methods

/**
 *	Notifies the user of the status of a given product.
 *
 *	@param	status						The status to display to the user.
 *	@param	product						The product for which the update pertains to.
 */
- (void)notifyStatus:(NSString *)status forProduct:(IAPProduct *)product
{
	[[[UIAlertView alloc] initWithTitle:@"Purchase Update"
								message:[[NSString alloc] initWithFormat:@"%@ : %@", status, product.skProduct.localizedTitle]
							   delegate:nil
					  cancelButtonTitle:@"Cool"
					  otherButtonTitles:nil] show];
}

@end