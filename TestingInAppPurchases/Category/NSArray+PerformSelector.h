//
//  NSArray+PerformSelector.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 22/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - NSArray with Perform Selector Methods Public Interface

@interface NSArray (PerformSelector) {}

#pragma mark - Public Methods

/**
 *	Sends the aSelector message to each object in the array, starting with the first object and continuing through the array to the last object.
 *
 *	@param	aSelector					A selector that identifies the message to send to the objects in the array.
 *	@param	objectA						The object to send as the first argument to each invocation of the aSelector method.
 *	@param	objectB						The object to send as the second argument to each invocation of the aSelector method.
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector
						withObject:(id)objectA
						withObject:(id)objectB;
/**
 *	Sends the aSelector message to each object in the array, starting with the first object and continuing through the array to the last object.
 *
 *	@param	aSelector					A selector that identifies the message to send to the objects in the array.
 *	@param	objectA						The object to send as the first argument to each invocation of the aSelector method.
 *	@param	objectB						The object to send as the second argument to each invocation of the aSelector method.
 *	@param	objectC						The object to send as the third argument to each invocation of the aSelector method.
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector
						withObject:(id)objectA
						withObject:(id)objectB
						withObject:(id)objectC;

@end