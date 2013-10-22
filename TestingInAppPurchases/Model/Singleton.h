//
//  Singleton.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - Singleton Public Interface

@interface Singleton : NSObject {}

/**
 *	Returns a shared instance of this class.
 *
 *	@return	A singleton instance of this class.
 */
+ (instancetype)sharedInstance;

@end