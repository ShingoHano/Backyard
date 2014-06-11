//
//  InAppPurchaseManager.m
//  Test1
//
//  Created by 羽野 真悟 on 13/04/05.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//
#import "InAppPurchaseManager.h"
#import "ViewController.h"
#import "NewViewController.h"
#import "iPadViewController.h"
//#define kInAppPurchaseProUpgradeProductId @"com.mushikago.InAppPurchaseXcode.unLock"
//#define kAppProductId @"com.mushikago.InAppPurchaseXcode"

@implementation InAppPurchaseManager

ViewController *viewControlle;
NewViewController *newViewControlle;
iPadViewController *ipadViewController;


// 「3. ペイメント処理を進めてよいか判断します。」部分
- (BOOL)canMakePurchases
{
    if([SKPaymentQueue canMakePayments])
    {
        return TRUE;
    }else {
        return FALSE;
    }
}

// 「4. プロダクトに関する情報を取得します。」部分
- (void)requestProductData:(NSString *) pID
{
    myProductRequest= [[SKProductsRequest alloc]
                       initWithProductIdentifiers: [NSSet setWithObject: pID]];
    myProductRequest.delegate = self;
    [myProductRequest start];
}

- (void)productsRequest:(SKProductsRequest *)request
     didReceiveResponse:(SKProductsResponse *)response
{
    
    if (response == nil) {
        [self showAlert:NSLocalizedString(@"responseなし",nil)];
        return;
    }
    
    // 確認できなかったidentifierをログに記録
    for (NSString *identifier in response.invalidProductIdentifiers) {
        NSLog(@"invalid product identifier: %@", identifier);
    }
    
    //NSArray *products = response.products; // UIを埋める
    //NSString *message = [NSString stringWithFormat:@"配列は%d個です。", [products count]];
    
    //NSString *message = @"何か戻りました。";
    //NSLog(@"配列は%d個です。", [products count]);
    //[self showAlert:message];
    
    
    //[myProductRequest autorelease];
    
    
    //Observer
    //InAppPurchaseStoreObserver *observer = [[InAppPurchaseStoreObserver alloc]init];
    //[[SKPaymentQueue defaultQueue] addTransactionObserver:observer];
    
    //  「6. トランザクションオブザーバをペイメントキューに登録します。」部分
    // （※本当は起動時の方がいい）
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    for (SKProduct *product in response.products ) {
        NSLog(@"valid product identifier: %@", product.productIdentifier);
        
        NSLog(@"%@",[product productIdentifier]);
        NSLog(@"%@",[product localizedTitle]);
        NSLog(@"%@",[product localizedDescription]);
        
        //SKPayment *payment = [SKPayment paymentWithProduct:product];
        //[[SKPaymentQueue defaultQueue] addPayment:payment];
        
        // 「11. ・・・ユーザ がStore内のアイテムを選択したら、ペイメントオブジェクトを作成し、ペイメントキューに追加 します。」部分
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    
    
}

// 「7. MyStoreObserverにpaymentQueue:updatedTransactions:メソッドを実装します。」部分
- (void)paymentQueue:(SKPaymentQueue *)queue
 updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchasing:
                // 購入処理中。基本何もしなくてよい。処理中であることがわかるようにインジケータをだすなど。
                break;
            case SKPaymentTransactionStatePurchased:
                // 購入処理成功
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                [self showAlert:NSLocalizedString(@"購入処理成功！",nil)];
                
                
                if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    // iPad
                    if([transaction.payment.productIdentifier isEqualToString:@"001"])
                    {
                        [ipadViewController addItem1];
                    }
                    if([transaction.payment.productIdentifier isEqualToString:@"002"])
                    {
                        [ipadViewController addItem2];
                    }
                    if([transaction.payment.productIdentifier isEqualToString:@"003"])
                    {
                        [ipadViewController addItem3];
                    }
                    if([transaction.payment.productIdentifier isEqualToString:@"004"])
                    {
                        [ipadViewController addItem4];
                    }

                }
                else {
                    CGRect frame = [[UIScreen mainScreen] applicationFrame];
                    
                    //iPhone4とiPhone5で処理を分岐
                    if((int)frame.size.height==548)
                    {
                        newViewControlle=nil;
                        if(!newViewControlle)
                            newViewControlle=[[NewViewController alloc]initWithNibName:@"NewViewController" bundle:nil];
                        if([transaction.payment.productIdentifier isEqualToString:@"001"])
                        {
                            [newViewControlle addItem1];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"002"])
                        {
                            [newViewControlle addItem2];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"003"])
                        {
                            [newViewControlle addItem3];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"004"])
                        {
                            [newViewControlle addItem4];
                        }
                    }
                    else
                    {
                        viewControlle=nil;
                        if(!viewControlle)
                            viewControlle=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
                        if([transaction.payment.productIdentifier isEqualToString:@"001"])
                        {
                            [viewControlle addItem1];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"002"])
                        {
                            [viewControlle addItem2];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"003"])
                        {
                            [viewControlle addItem3];
                        }
                        if([transaction.payment.productIdentifier isEqualToString:@"004"])
                        {
                            [viewControlle addItem4];
                        }
                    }
                }

                NSLog(@"購入処理成功！");
                NSLog(@"transaction : %@",transaction);
                NSLog(@"transaction.payment.productIdentifier : %@",transaction.payment.productIdentifier);
                [queue finishTransaction: transaction];
                break;
            case SKPaymentTransactionStateFailed:
                // 購入処理失敗。ユーザが購入処理をキャンセルした場合もここ
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                if (transaction.error.code != SKErrorPaymentCancelled)
                {
                    // 必要に応じてここでエラーを表示する
                    [self showAlert:[transaction.error localizedDescription]];
                    NSLog(@"購入処理失敗。");
                    NSLog(@"error : %@",[transaction.error localizedDescription]);
                }
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                //リストア処理開始
                [self showAlert:NSLocalizedString(@"リストア処理開始",nil)];
                NSLog(@"リストア処理");
                NSLog(@"transaction : %@",transaction);
                NSLog(@"transaction.originalTransaction.payment.productIdentifier : %@",transaction.originalTransaction.payment.productIdentifier);
                [queue finishTransaction:transaction];
            default:
                break;
        }
    }
}

//Alert
- (void)showAlert:(NSString *)msg
{
    UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:NSLocalizedString(@"メッセージ",nil)
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}

@end