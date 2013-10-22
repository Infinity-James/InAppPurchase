//
//  Singleton.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "Singleton.h"

#pragma mark - Singleton Implementation

@implementation Singleton {}

#pragma mark - Singleton Methods

/**
 *	Returns a shared instance of this class.
 *
 *	@return	A singleton instance of this class.
 */
+ (instancetype)sharedInstance
{
	static Singleton *sharedInstance;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken,
	^{
		sharedInstance					= [[self alloc] init];
	});
	
	return sharedInstance;
}

@end