//
//  InAppPurchaseManager.h
//  Test1
//
//  Created by 羽野 真悟 on 13/04/05.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@interface InAppPurchaseManager : NSObject <SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    //SKProduct *myProduct;
    SKProductsRequest *myProductRequest;
}

//public method
- (BOOL)canMakePurchases;
- (void)requestProductData:(NSString *) pID;
@end