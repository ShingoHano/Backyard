//
//  MenuViewController.m
//  scrollGame
//
//  Created by 真悟 羽野 on 12/09/11.
//  Copyright (c) 2012年 NNTP. All rights reserved.
//

#import "MenuViewController.h"
#import "ViewController.h"
#import "NewViewController.h"
#import "WCAlertView.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

ViewController *viewController;             //ゲーム画面用のビューコントローラー
NewViewController *newViewController;

/*******************************************************************
 関数名　　initWithNibName
 概要    UIViewControllerクラスの初期処理　他Viewからの画面遷移に必要
 引数	(NSString *)nibNameOrNil        :xib
 (NSBundle *)nibBundleOrNil      :Bundle
 戻り値	(id)initWithNibName             :xibの名前
 *******************************************************************/
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*******************************************************************
 関数名　　viewDidLoad
 概要		viewが呼び出された時の初期処理　各種変数の初期化など
 引数		なし
 戻り値	なし
 *******************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*******************************************************************
 関数名　　viewDidUnload
 概要	 viewを閉じる際の処理
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.view removeFromSuperview];
}

/*******************************************************************
 関数名　　shouldAutorotateToInterfaceOrientation
 概要	 iPhoneの画面の向きを判定する
 引数　　　(UIInterfaceOrientation)interfaceOrientation:画面の向き
 戻り値　　なし
 *******************************************************************/
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*******************************************************************
 関数名　　displayView
 概要	 スタートボタン押下時の画面遷移処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
-(IBAction) displayView:(id) sender{
    sleep(2);
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    //iPhone4とiPhone5で処理を分岐
    if((int)frame.size.height==548)
    {
        newViewController=[[NewViewController alloc]initWithNibName:@"NewViewController" bundle:nil];
        [self.view addSubview:newViewController.view];
        [newViewController viewDidLoad];
    }
    else
    {
        viewController=[[ViewController alloc]initWithNibName:@"ViewController" bundle:nil];
        [self.view addSubview:viewController.view];
        [viewController viewDidLoad];
    }
}

-(IBAction) ruleShow:(id)sender
{
    srand(time(nil));
    int num=rand()%10;
    
    NSString *message;
    
    switch(num)
    {
        case 0:
            message = NSLocalizedString(@"缶を上フリックで補充しよう",nil);
            break;
        case 1:
            message = NSLocalizedString(@"親ペンギンは5つまとめて購入",nil);
            break;
        case 2:
            message = NSLocalizedString(@"ペンギンのスピードは時給アップとともに速くなるよ",nil);
            break;
        case 3:
            message = NSLocalizedString(@"5秒ごとに時給アップ！",nil);
            break;
        case 4:
            message = NSLocalizedString(@"過去のスコアに応じて難易度が自動で調整されるよ",nil);
            break;
        case 5:
            message = NSLocalizedString(@"親ペンギンの出現は時給とともにアップ",nil);
            break;
        case 6:
            message = NSLocalizedString(@"親ペンギンが何を買うかみきわめてしっかり補充しよう",nil);
            break;
        case 7:
            message = NSLocalizedString(@"缶が1列全部なくなったらゲームオーバーだよ",nil);
            break;
        case 8:
            message = NSLocalizedString(@"時給はどこまで上がるかな",nil);
            break;
        case 9:
            message = NSLocalizedString(@"お店のバックヤードが舞台だ",nil);
            break;
        default:
            break;
    }
    
    UIFont * titleFont = [UIFont fontWithName:@"ArialHebrew-Bold" size:18.0f];
    UIFont * messageFont = [UIFont fontWithName:@"Helvetica" size:14.0f];
    
    [WCAlertView setDefaultCustomiaztonBlock:^(WCAlertView *alertView) {
        alertView.labelTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
        alertView.labelShadowColor = [UIColor whiteColor];
        
        UIColor *topGradient = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f];
        UIColor *middleGradient = [UIColor colorWithRed:0.93f green:0.94f blue:0.96f alpha:1.0f];
        UIColor *bottomGradient = [UIColor colorWithRed:0.89f green:0.89f blue:0.92f alpha:1.00f];
        alertView.gradientColors = @[topGradient,middleGradient,bottomGradient];
        
        alertView.outerFrameColor = [UIColor colorWithRed:250.0f/255.0f green:250.0f/255.0f blue:250.0f/255.0f alpha:1.0f];
        
        alertView.buttonTextColor = [UIColor colorWithRed:0.11f green:0.08f blue:0.39f alpha:1.00f];
        alertView.buttonShadowColor = [UIColor whiteColor];
        
        alertView.titleFont = titleFont;
        alertView.messageFont = messageFont;
    }];
    
    [WCAlertView showAlertWithTitle:NSLocalizedString(@"攻略のヒント",nil) message:message customizationBlock:^(WCAlertView *alertView) {
        
        alertView.style = WCAlertViewStyleWhite;
    } completionBlock:^(NSUInteger buttonIndex, WCAlertView *alertView) {
    } cancelButtonTitle:NSLocalizedString(@"確認",nil) otherButtonTitles:/*@"OK"*/ nil];
}



@end
