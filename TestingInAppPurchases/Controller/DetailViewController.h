//
//  DetailViewController.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 22/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

@class IAPProduct;

#pragma mark - Detail View Controller Public Interface

@interface DetailViewController : UIViewController {}

#pragma mark - Public Properties

/**	The product displayed by this view controller.	*/
@property (nonatomic, strong)		IAPProduct		*product;

@end