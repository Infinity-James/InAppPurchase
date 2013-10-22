//
//  SpecificIAPHelper.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "IAPProduct.h"
#import "SpecificIAPHelper.h"

#pragma mark - Specific In-App Purchase Helper Implementation

@implementation SpecificIAPHelper {}

#pragma mark - Initialisation

/**
 *	Implemented by subclasses to initialize a new object (the receiver) immediately after memory for it has been allocated.
 *
 *	@return	An initialized object.
 */
- (instancetype)init
{
	IAPProduct *upgrade				= [[IAPProduct alloc] initWithProductIdentifier:@"co.andbeyond.testinginapppurchases.testupgrade"];
	IAPProduct *consumable			= [[IAPProduct alloc] initWithProductIdentifier:@"co.andbeyond.testinginapppurchases.testconsumable"];
	NSDictionary *products			= @{upgrade.productIdentifier		: upgrade,
										consumable.productIdentifier	: consumable};
	if (self = [super initWithProducts:products])
	{
		
	}
	
	return self;
}

@end