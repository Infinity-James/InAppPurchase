//
//  ProductCell.h
//  TestingInAppPurchases
//
//  Created by James Valaitis on 21/10/2013.
//  Copyright (c) 2013 &Beyond. All rights reserved.
//

#pragma mark - Product Cell Public Interface

@interface ProductCell : UITableViewCell {}

/**	The detail subtitle label.	*/
@property (nonatomic, strong, readonly)	UILabel		*detailLabel;
/**	A view to display the icon of the product.	*/
@property (nonatomic, strong, readonly) UIImageView	*iconView;
/**	The main title label.	*/
@property (nonatomic, strong, readonly)	UILabel		*mainLabel;
/**	A label displaying the price of the product.	*/
@property (nonatomic, strong, readonly)	UILabel		*priceLabel;

@end