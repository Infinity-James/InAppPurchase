//
//  NSArray+PerformSelector.m
//  TestingInAppPurchases
//
//  Created by James Valaitis on 22/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#import "NSArray+PerformSelector.h"

#pragma mark - NSArray with Perform Selector Methods Implementation

@implementation NSArray (PerformSelector)

#pragma mark - Perform Selector Methods

/**
 *	Sends the aSelector message to each object in the array, starting with the first object and continuing through the array to the last object.
 *
 *	@param	aSelector					A selector that identifies the message to send to the objects in the array.
 *	@param	objectA						The object to send as the first argument to each invocation of the aSelector method.
 *	@param	objectB						The object to send as the second argument to each invocation of the aSelector method.
 */
- (void)makeObjectsPerformSelector:(SEL)aSelector
						withObject:(id)objectA
						withObject:(id)objectB
{
	for(id obj in self)
	{
		NSMethodSignature *signature	= [obj methodSignatureForSelector:aSelector];
		NSInvocation *invocation		= [NSInvocation invocationWithMethodSignature:signature];
		[invocation setSelector:aSelector];
		[invocation setArgument:(__bridge void *)(objectA) atIndex:2];
		[invocation setArgument:(__bridge void *)(objectB) atIndex:3];
		[invocation setTarget:obj];
		[invocation invoke];
	}
}

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
						withObject:(id)objectC
{
	for(id obj in self)
	{
		NSMethodSignature *signature	= [obj methodSignatureForSelector:aSelector];
		NSInvocation *invocation		= [NSInvocation invocationWithMethodSignature:signature];
		[invocation setSelector:aSelector];
		[invocation setArgument:(__bridge void *)(objectA) atIndex:2];
		[invocation setArgument:(__bridge void *)(objectB) atIndex:3];
		[invocation setArgument:(__bridge void *)(objectC) atIndex:4];
		[invocation setTarget:obj];
		[invocation invoke];
	}
}

@end