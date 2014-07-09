//
//  ScoreViewController.m
//  scrollGame
//
//  Created by 真悟 羽野 on 12/09/18.
//  Copyright (c) 2012年 NNTP. All rights reserved.
//

#import "ScoreViewController.h"

@interface ScoreViewController ()

@end

@implementation ScoreViewController

@synthesize scoreLabel1,scoreLabel2,scoreLabel3,scoreLabel4,imageView;
@synthesize itemLabel1,itemLabel2,itemLabel3,itemLabel4;

ViewController *viewController;
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
 関数名  viewDidLoad
 概要	viewが呼び出された時の初期処理　各種変数の初期化など
 引数	なし
 戻り値	なし
 *******************************************************************/
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    itemLabel1.text=NSLocalizedString(@"時給", nil);
    itemLabel2.text=NSLocalizedString(@"親ペンギン出現", nil);
    itemLabel3.text=NSLocalizedString(@"補充回数", nil);
    itemLabel4.text=NSLocalizedString(@"ランク", nil);
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
    
    //BGMストップ
//    [player stop];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

/*******************************************************************
 関数名　　displayMenu
 概要	 TOPボタン押下時の画面遷移処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
-(IBAction) displayView:(id)sender{
    sleep(1);
    
    [self.view removeFromSuperview];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    
    //iPhone4とiPhone5で処理を分岐
    if((int)frame.size.height==548)
    {
        [newViewController viewDidLoad];
//        [self.view addSubview:newViewController.view];
    }
    else
    {
        [viewController viewDidLoad];
//        [self.view addSubview:viewController.view];
    }    
}

/*******************************************************************
 関数名　　displayScore
 概要	 引数で受け取ったスコアとの表示およびランク判定
 引数　　 array[0]:給料
 array[1]:
 array[2]:
 戻り値	なし
 *******************************************************************/
-(void) displayScore:(int[])array
{
    self.scoreLabel1.text=[NSString stringWithFormat:@"%04d",array[0]];
    self.scoreLabel2.text=[NSString stringWithFormat:@"%04d",array[1]];
    self.scoreLabel3.text=[NSString stringWithFormat:@"%04d",array[2]];
    
    if(array[0]<1200)
    {
        self.scoreLabel4.text=@"F";
    }
    else if(array[0]<1800)
    {
        self.scoreLabel4.text=@"E";
    }
    else if(array[0]<2400)
    {
        self.scoreLabel4.text=@"D";
    }
    else if(array[0]<3000)
    {
        self.scoreLabel4.text=@"C";
    }
    else if(array[0]<3600)
    {
        self.scoreLabel4.text=@"B";
    }
    else if(array[0]<4200)
    {
        self.scoreLabel4.text=@"A";
    }
    else if(array[0]<5400)
    {
        self.scoreLabel4.text=@"S";
    }
    else if(array[0]<6600)
    {
        self.scoreLabel4.text=@"γ";
    }
    else if(array[0]<7800)
    {
        self.scoreLabel4.text=@"β";
    }
    else
    {
        self.scoreLabel4.text=@"α";
    }
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

@end
