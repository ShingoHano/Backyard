//
//  ViewController.m
//  scrollGame
//
//  Created by 真悟 羽野 on 12/09/10.
//  Copyright (c) 2012年 NNTP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize viewImage1,viewImage2,viewImage3,rightButton,leftButton;
@synthesize startButton,stopButton,scoreLabel,resultLabel;
@synthesize imageView1_1,imageView1_2,imageView1_3,imageView1_4,imageView1_5,imageView1_6,imageView1_7,imageView1_8,imageView1_9,imageView1_10,imageView1_11,imageView1_12;
@synthesize imageView2_1,imageView2_2,imageView2_3,imageView2_4,imageView2_5,imageView2_6,imageView2_7,imageView2_8,imageView2_9,imageView2_10,imageView2_11,imageView2_12;
@synthesize imageView3_1,imageView3_2,imageView3_3,imageView3_4,imageView3_5,imageView3_6,imageView3_7,imageView3_8,imageView3_9,imageView3_10,imageView3_11,imageView3_12;
@synthesize imageView4_1,imageView4_2,imageView4_3,imageView4_4,imageView4_5,imageView4_6,imageView4_7,imageView4_8,imageView4_9,imageView4_10,imageView4_11,imageView4_12;
@synthesize imageView5_1,imageView5_2,imageView5_3,imageView5_4,imageView5_5,imageView5_6,imageView5_7,imageView5_8,imageView5_9,imageView5_10,imageView5_11,imageView5_12;
@synthesize imageView6_1,imageView6_2,imageView6_3,imageView6_4,imageView6_5,imageView6_6,imageView6_7,imageView6_8,imageView6_9,imageView6_10,imageView6_11,imageView6_12;
@synthesize item,purchaseView,options,infoLabel;

InAppPurchaseManager *appMng;
MenuViewController *menuView;   //メニュー画面のビューコントローラー
ScoreViewController *scoreView; //スコア用のビューコントローラー

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
	// Do any additional setup after loading the view, typically from a nib.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    upItem=[userDefaults integerForKey:@"UPITEM"];
    fullItem=[userDefaults integerForKey:@"FULLITEM"];
    firstFlag=[userDefaults integerForKey:@"FIRSTFLAG"];
    firstFlag=firstFlag?1:0;
    
    if(firstFlag!=1)
    {
        upItem=10;
        fullItem=5;
        [userDefaults setInteger:upItem forKey:@"UPITEM"];
        [userDefaults setInteger:fullItem forKey:@"FULLITEM"];
        [userDefaults setInteger:1 forKey:@"FIRSTFLAG"];
        [userDefaults synchronize];
    }
    
    //変数の初期化
    PatternType=0;          //スクロールのイメージパターン用変数
    Image1Count=12;         //1種類目の画像カウント変数
    Image2Count=12;         //2種類目の画像カウント変数
    Image3Count=12;         //3種類目の画像カウント変数
    Image4Count=12;         //4種類目の画像カウント変数
    Image5Count=12;         //5種類目の画像カウント変数
    Image6Count=12;         //6種類目の画像カウント変数
    FlagTime=0;             //ゲーム時間の判定用変数
    GameLevel=0;            //ゲームの難易度用変数
    HourlyWages=700;        //時給用変数
    TimeDif=0;              //タイム計測用変数
    TempTime=0;             //ポーズ時タイム加算用変数
    FlagPause=0;            //ポーズ判定用変数
    BossCount=0;            //ボスの出現回数
    TouchCount=0;           //缶の補充回数
    PastAverage=700;        //過去の平均スコア(時給)
    flagItem=0;
    labelFont=[UIFont fontWithName:@"Helvetica-Bold" size:12];
    
    
    //イメージファイル名を文字列の配列に格納する
    imageStr[0]=@"缶_立体_みかんジュース.png";
    imageStr[1]=@"缶_立体_トマトジュース.png";
    imageStr[2]=@"缶_立体_コンポタ.png";
    imageStr[3]=@"缶_立体_コーヒー.png";
    imageStr[4]=@"缶_立体_コーヒーブラック.png";
    imageStr[5]=@"缶_立体_葡萄ジュース.png";
    
    //ポイント初期表示
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",HourlyWages];
    
    //イメージを全て表示する
    imageView1_1.hidden=NO;
    imageView1_2.hidden=NO;
    imageView1_3.hidden=NO;
    imageView1_4.hidden=NO;
    imageView1_5.hidden=NO;
    imageView1_6.hidden=NO;
    imageView1_7.hidden=NO;
    imageView1_8.hidden=NO;
    imageView1_9.hidden=NO;
    imageView1_10.hidden=NO;
    imageView1_11.hidden=NO;
    imageView1_12.hidden=NO;
    imageView2_1.hidden=NO;
    imageView2_2.hidden=NO;
    imageView2_3.hidden=NO;
    imageView2_4.hidden=NO;
    imageView2_5.hidden=NO;
    imageView2_6.hidden=NO;
    imageView2_7.hidden=NO;
    imageView2_8.hidden=NO;
    imageView2_9.hidden=NO;
    imageView2_10.hidden=NO;
    imageView2_11.hidden=NO;
    imageView2_12.hidden=NO;
    imageView3_1.hidden=NO;
    imageView3_2.hidden=NO;
    imageView3_3.hidden=NO;
    imageView3_4.hidden=NO;
    imageView3_5.hidden=NO;
    imageView3_6.hidden=NO;
    imageView3_7.hidden=NO;
    imageView3_8.hidden=NO;
    imageView3_9.hidden=NO;
    imageView3_10.hidden=NO;
    imageView3_11.hidden=NO;
    imageView3_12.hidden=NO;
    imageView4_1.hidden=NO;
    imageView4_2.hidden=NO;
    imageView4_3.hidden=NO;
    imageView4_4.hidden=NO;
    imageView4_5.hidden=NO;
    imageView4_6.hidden=NO;
    imageView4_7.hidden=NO;
    imageView4_8.hidden=NO;
    imageView4_9.hidden=NO;
    imageView4_10.hidden=NO;
    imageView4_11.hidden=NO;
    imageView4_12.hidden=NO;
    imageView5_1.hidden=NO;
    imageView5_2.hidden=NO;
    imageView5_3.hidden=NO;
    imageView5_4.hidden=NO;
    imageView5_5.hidden=NO;
    imageView5_6.hidden=NO;
    imageView5_7.hidden=NO;
    imageView5_8.hidden=NO;
    imageView5_9.hidden=NO;
    imageView5_10.hidden=NO;
    imageView5_11.hidden=NO;
    imageView5_12.hidden=NO;
    imageView6_1.hidden=NO;
    imageView6_2.hidden=NO;
    imageView6_3.hidden=NO;
    imageView6_4.hidden=NO;
    imageView6_5.hidden=NO;
    imageView6_6.hidden=NO;
    imageView6_7.hidden=NO;
    imageView6_8.hidden=NO;
    imageView6_9.hidden=NO;
    imageView6_10.hidden=NO;
    imageView6_11.hidden=NO;
    imageView6_12.hidden=NO;
    
    resultLabel.hidden=YES;             //ゲームオーバー表示用ラベルを非表示
    [self dispTabImage:0];              //画面下部スクロールイメージ初期表示
    srand(time(nil));                   //乱数初期化
    self.startButton.enabled=true;      //スタートボタン有効
    self.stopButton.enabled=false;      //ストップボタン無効
    
    /*
    item.layer.borderWidth = 5.0f;
    item.layer.borderColor = [[UIColor whiteColor] CGColor];
    item.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    
    
    fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fullButton.frame = CGRectMake(40, 10, 30, 30);
    fullButton.titleLabel.text=@"";
    UIImage *fullImage = [UIImage imageNamed:@"缶_立体_みかんジュース"];
    [fullButton setBackgroundImage:fullImage forState:UIControlStateNormal];
    fullButton.tintColor=[UIColor lightGrayColor];
    [fullButton addTarget:self action:@selector(fullImage)
         forControlEvents:UIControlEventTouchUpInside];
    
    fullLabel=[[UILabel alloc] initWithFrame:CGRectMake(40, 40, 30, 15)];
    fullLabel.textColor=[UIColor darkGrayColor];
    fullLabel.text= [NSString stringWithFormat:@"%d",fullItem];
    fullLabel.textAlignment=NSTextAlignmentCenter;
    fullLabel.font=labelFont;
    
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(110, 10, 30, 30);
    upButton.titleLabel.text=@"";
    UIImage *upImage = [UIImage imageNamed:@"carving_time_icon_32"];
    [upButton setBackgroundImage:upImage forState:UIControlStateNormal];
    upButton.tintColor=[UIColor lightGrayColor];
    [upButton addTarget:self action:@selector(upUp)
       forControlEvents:UIControlEventTouchUpInside];
    
    upLabel=[[UILabel alloc] initWithFrame:CGRectMake(110, 40, 30, 15)];
    upLabel.textColor=[UIColor darkGrayColor];
    upLabel.text=[NSString stringWithFormat:@"%d",upItem];
    upLabel.textAlignment=NSTextAlignmentCenter;
    upLabel.font=labelFont;
    
    bossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bossButton.frame = CGRectMake(180, 10, 30, 30);
    bossButton.titleLabel.text=@"";
    UIImage *bossImage = [UIImage imageNamed:@"penguin"];
    [bossButton setBackgroundImage:bossImage forState:UIControlStateNormal];
    bossButton.tintColor=[UIColor lightGrayColor];
    [bossButton addTarget:self action:@selector(bossAnimation)
         forControlEvents:UIControlEventTouchUpInside];
    
    bossLabel=[[UILabel alloc] initWithFrame:CGRectMake(180, 40, 30, 15)];
    bossLabel.textColor=[UIColor darkGrayColor];
    bossLabel.text=@"∞";
    bossLabel.textAlignment=NSTextAlignmentCenter;
    bossLabel.font=labelFont;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(250, 10, 30, 30);
    addButton.titleLabel.text=@"";
    UIImage *addImage = [UIImage imageNamed:@"shopping_cart"];
    [addButton setBackgroundImage:addImage forState:UIControlStateNormal];
    addButton.tintColor=[UIColor darkGrayColor];
    [addButton addTarget:self action:@selector(addPurchase)
        forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *addLabel=[[UILabel alloc] initWithFrame:CGRectMake(240, 40, 50, 15)];
    addLabel.textColor=[UIColor darkGrayColor];
    addLabel.text=NSLocalizedString(@"購入",nil);
    addLabel.textAlignment=NSTextAlignmentCenter;
    addLabel.font=labelFont;
    
    purchaseView.layer.borderWidth = 5.0f;
    purchaseView.layer.borderColor = [[UIColor whiteColor] CGColor];
    purchaseView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    
    UIImageView *item1=[[UIImageView alloc]initWithFrame:CGRectMake(20,25,30,30)];
    item1.image=[UIImage imageNamed:@"缶_立体_みかんジュース.png"];
    [purchaseView addSubview:item1];
    
    UILabel *itemLabel1=[[UILabel alloc]initWithFrame:CGRectMake(80, 30, 40, 20)];
    itemLabel1.text=@"×5";
    itemLabel1.textColor=[UIColor darkGrayColor];
    itemLabel1.font=labelFont;
    [purchaseView addSubview:itemLabel1];
    
    UILabel *itemLabel2=[[UILabel alloc]initWithFrame:CGRectMake(190, 30, 60, 20)];
    itemLabel2.text=NSLocalizedString(@"85円",nil);
    itemLabel2.textColor=[UIColor darkGrayColor];
    itemLabel2.font=labelFont;
    [purchaseView addSubview:itemLabel2];
    
    UIButton* itemButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton1.frame = CGRectMake(260, 20, 40, 40);
    itemButton1.titleLabel.text=NSLocalizedString(@"購入",nil);
    UIImage *itemImage = [UIImage imageNamed:@"buy.png"];
    [itemButton1 setBackgroundImage:itemImage forState:UIControlStateNormal];
    itemButton1.tintColor=[UIColor lightGrayColor];
    [itemButton1 addTarget:self action:@selector(addPurchase1)
          forControlEvents:UIControlEventTouchUpInside];
    [purchaseView addSubview:itemButton1];
    
    UIImageView *item2=[[UIImageView alloc]initWithFrame:CGRectMake(20,85,30,30)];
    item2.image=[UIImage imageNamed:@"carving_time_icon_32"];
    [purchaseView addSubview:item2];
    
    UILabel *itemLabel3=[[UILabel alloc]initWithFrame:CGRectMake(80, 90, 40, 20)];
    itemLabel3.text=@"×5";
    itemLabel3.textColor=[UIColor darkGrayColor];
    itemLabel3.font=labelFont;
    [purchaseView addSubview:itemLabel3];
    
    UILabel *itemLabel4=[[UILabel alloc]initWithFrame:CGRectMake(190, 90, 60, 20)];
    itemLabel4.text=NSLocalizedString(@"85円",nil);
    itemLabel4.textColor=[UIColor darkGrayColor];
    itemLabel4.font=labelFont;
    [purchaseView addSubview:itemLabel4];
    
    UIButton* itemButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton2.frame = CGRectMake(260, 80, 40, 40);
    itemButton2.titleLabel.text=NSLocalizedString(@"購入",nil);
    UIImage *itemImage2 = [UIImage imageNamed:@"buy.png"];
    [itemButton2 setBackgroundImage:itemImage2 forState:UIControlStateNormal];
    itemButton2.tintColor=[UIColor lightGrayColor];
    [itemButton2 addTarget:self action:@selector(addPurchase2)
          forControlEvents:UIControlEventTouchUpInside];
    [purchaseView addSubview:itemButton2];
    
    
    
    UIImageView *item3=[[UIImageView alloc]initWithFrame:CGRectMake(20,145,30,30)];
    item3.image=[UIImage imageNamed:@"缶_立体_みかんジュース.png"];
    [purchaseView addSubview:item3];
    
    UILabel *itemLabel5=[[UILabel alloc]initWithFrame:CGRectMake(80, 150, 40, 20)];
    itemLabel5.text=@"×20";
    itemLabel5.textColor=[UIColor darkGrayColor];
    itemLabel5.font=labelFont;
    [purchaseView addSubview:itemLabel5];
    
    UILabel *itemLabel6=[[UILabel alloc]initWithFrame:CGRectMake(190, 150, 60, 20)];
    itemLabel6.text=NSLocalizedString(@"250円",nil);
    itemLabel6.textColor=[UIColor darkGrayColor];
    itemLabel6.font=labelFont;
    [purchaseView addSubview:itemLabel6];
    
    UIButton* itemButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton3.frame = CGRectMake(260, 140, 40, 40);
    itemButton3.titleLabel.text=NSLocalizedString(@"購入",nil);
    [itemButton3 setBackgroundImage:itemImage forState:UIControlStateNormal];
    itemButton3.tintColor=[UIColor lightGrayColor];
    [itemButton3 addTarget:self action:@selector(addPurchase3)
          forControlEvents:UIControlEventTouchUpInside];
    [purchaseView addSubview:itemButton3];
    
    
    UIImageView *item4=[[UIImageView alloc]initWithFrame:CGRectMake(20,205,30,30)];
    item4.image=[UIImage imageNamed:@"carving_time_icon_32"];
    [purchaseView addSubview:item4];
    
    UILabel *itemLabel7=[[UILabel alloc]initWithFrame:CGRectMake(80, 210, 40, 20)];
    itemLabel7.text=@"×20";
    itemLabel7.textColor=[UIColor darkGrayColor];
    itemLabel7.font=labelFont;
    [purchaseView addSubview:itemLabel7];
    
    UILabel *itemLabel8=[[UILabel alloc]initWithFrame:CGRectMake(190, 210, 60, 20)];
    itemLabel8.text=NSLocalizedString(@"250円",nil);
    itemLabel8.textColor=[UIColor darkGrayColor];
    itemLabel8.font=labelFont;
    [purchaseView addSubview:itemLabel8];
    
    UIButton* itemButton4 = [UIButton buttonWithType:UIButtonTypeCustom];
    itemButton4.frame = CGRectMake(260, 200, 40, 40);
    itemButton4.titleLabel.text=NSLocalizedString(@"購入",nil);
    [itemButton4 setBackgroundImage:itemImage2 forState:UIControlStateNormal];
    itemButton4.tintColor=[UIColor lightGrayColor];
    [itemButton4 addTarget:self action:@selector(addPurchase4)
          forControlEvents:UIControlEventTouchUpInside];
    [purchaseView addSubview:itemButton4];
    
    
    UIButton* purchaseCancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    purchaseCancelButton.frame = CGRectMake(145, 280, 30, 30);
    UIImage *itemImage3 = [UIImage imageNamed:@"button_cancel.png"];
    [purchaseCancelButton setBackgroundImage:itemImage3 forState:UIControlStateNormal];
    purchaseCancelButton.tintColor=[UIColor lightGrayColor];
    [purchaseCancelButton addTarget:self action:@selector(addPurchase)
                   forControlEvents:UIControlEventTouchUpInside];
    [purchaseView addSubview:purchaseCancelButton];
    
    if(fullItem>0)
    {
        fullButton.enabled=true;
    }
    else
    {
        fullButton.enabled=false;
    }
    
    if(upItem>0)
    {
        upButton.enabled=true;
    }
    else
    {
        upButton.enabled=false;
    }
    
    [item addSubview:fullButton];
    [item addSubview:fullLabel];
    [item addSubview:upButton];
    [item addSubview:upLabel];
    [item addSubview:bossButton];
    [item addSubview:bossLabel];
    [item addSubview:addButton];
    [item addSubview:addLabel];*/
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
    
}

/*******************************************************************
 関数名　　shouldAutorotateToInterfaceOrientation
 概要	 iPhoneの画面の向きを判定する
 引数　　　(UIInterfaceOrientation)interfaceOrientation:画面の向き
 戻り値　　なし
 *******************************************************************/

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
 {
 
 //   return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
 }*/

-(void)addPurchase
{
/*    UIButton *demoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [demoBtn setTitle:@"Show List" forState:UIControlStateNormal];
    demoBtn.frame = CGRectMake(100, 220, 120, 44);
    [demoBtn addTarget:self action:@selector(showListView) forControlEvents:UIControlEventTouchUpInside];
    [self.window addSubview:demoBtn];*/
    /*
    infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 320, 30)];
    infoLabel.textAlignment = UITextAlignmentCenter;
    [self.window addSubview:infoLabel];*/
    
    if(FlagTime==1)
        [self pauseGame];

    
    options = [NSArray arrayWithObjects:
               
                [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"fullIcon.png"],@"img",NSLocalizedString(@"×5             85円",nil),@"text", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"upIcon.png"],@"img",NSLocalizedString(@"×5             85円",nil),@"text", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"fullIcon.png"],@"img",NSLocalizedString(@"×20          250円",nil),@"text", nil],
                [NSDictionary dictionaryWithObjectsAndKeys:[UIImage imageNamed:@"upIcon.png"],@"img",NSLocalizedString(@"×20          250円",nil),@"text", nil],
                nil];
    
    [self showListView];

    
    /*
  
    BlockActionSheet *sheet = [BlockActionSheet sheetWithTitle:@"This is a sheet title that will span more than one line"];
    [sheet setCancelButtonWithTitle:@"Cancel Button" block:nil];
    [sheet setDestructiveButtonWithTitle:@"Destructive Button" block:nil];
    [sheet addButtonWithTitle:@"Show Action Sheet on top" block:^{
//        [self showActionSheet:nil];
    }];
    [sheet addButtonWithTitle:@"Show another alert" block:^{
        [self showAlert:nil];
    }];
    [sheet showInView:self.view];*/
    
    /*
    if(purchaseView.alpha==0)
    {
        if(FlagTime==1)
        {
            [self pauseGame];
        }
        
        [UIView animateWithDuration:0.2 animations:
         ^(void){
             purchaseView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1.1f, 1.1f);
             purchaseView.alpha = 0.5;
         }
                         completion:^(BOOL finished){
                             [self bounceOutPurchaseAnimationStoped];
                         }];
    }
    else
    {
        purchaseView.alpha = 0;
        purchaseView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.6, 0.6);
    }*/
}


- (void)showListView {
    if(FlagTime==1)
    {
        [self pauseGame];
    }

    
    LeveyPopListView *lplv = [[LeveyPopListView alloc] initWithTitle:@"Buying Items" options:options handler:^(NSInteger anIndex) {
        if(anIndex==0)
        {
            [self addPurchase1];
        }
        else if(anIndex==1)
        {
            [self addPurchase2];
        }
        else if(anIndex==2)
        {
            [self addPurchase3];
        }
        else if(anIndex==3)
        {
            [self addPurchase4];
        }
        NSLog(@"%d",anIndex);
        //infoLabel.text = [NSString stringWithFormat:@"You have selected %@",options[anIndex]];
    }];
    //    lplv.delegate = self;
    [lplv showInView:self.view animated:YES];
}

#pragma mark - LeveyPopListView delegates
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex {

//    infoLabel.text = [NSString stringWithFormat:@"You have selected %@",options[anIndex]];
}
- (void)leveyPopListViewDidCancel {
    infoLabel.text = @"You have cancelled";
}

/*
- (void)bounceOutPurchaseAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         purchaseView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         purchaseView.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInPurchaseAnimationStoped];
                     }];
}
- (void)bounceInPurchaseAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         purchaseView.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         purchaseView.alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self purchaseAnimationStoped];
                     }];
}
- (void)animationStoped
{
    
}*/


-(void)addPurchase1
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    appMng=nil;
    if(!appMng)
    {
        appMng = [[InAppPurchaseManager alloc]init];
    }
    
    if(appMng.canMakePurchases)
    {
        [appMng requestProductData:@"001"];
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showAlert:NSLocalizedString(@"課金が許可されていません。",nil)];
    }
}

-(void)addPurchase2
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    appMng=nil;
    if(!appMng)
    {
        appMng = [[InAppPurchaseManager alloc]init];
    }
    
    if(appMng.canMakePurchases)
    {
        [appMng requestProductData:@"002"];
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showAlert:NSLocalizedString(@"課金が許可されていません。",nil)];
    }
}

-(void)addPurchase3
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    appMng=nil;
    if(!appMng)
    {
        appMng = [[InAppPurchaseManager alloc]init];
    }
    
    if(appMng.canMakePurchases)
    {
        [appMng requestProductData:@"003"];
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showAlert:NSLocalizedString(@"課金が許可されていません。",nil)];
    }
}

-(void)addPurchase4
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    appMng=nil;
    if(!appMng)
    {
        appMng = [[InAppPurchaseManager alloc]init];
    }
    
    if(appMng.canMakePurchases)
    {
        [appMng requestProductData:@"004"];
    }
    else
    {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        [self showAlert:NSLocalizedString(@"課金が許可されていません。",nil)];
    }
}



-(void)addItem1
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    fullItem=[userDefaults integerForKey:@"FULLITEM"];
    fullItem+=5;    
    [userDefaults setInteger:fullItem forKey:@"FULLITEM"];
    [userDefaults synchronize];
//    appMng=nil;
}

-(void)addItem2
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    upItem=[userDefaults integerForKey:@"UPITEM"];
    upItem+=5;
//    upLabel.text=[NSString stringWithFormat:@"%d",upItem];
    [userDefaults setInteger:upItem forKey:@"UPITEM"];
    [userDefaults synchronize];
//    appMng=nil;
}

-(void)addItem3
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    fullItem=[userDefaults integerForKey:@"FULLITEM"];
    fullItem+=20;
//    fullLabel.text=[NSString stringWithFormat:@"%d",fullItem];
    [userDefaults setInteger:fullItem forKey:@"FULLITEM"];
    [userDefaults synchronize];
//    appMng=nil;
}

-(void)addItem4
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    upItem=[userDefaults integerForKey:@"UPITEM"];
    upItem+=20;
//    upLabel.text=[NSString stringWithFormat:@"%d",upItem];
    [userDefaults setInteger:upItem forKey:@"UPITEM"];
    [userDefaults synchronize];
//    appMng=nil;
}

- (void)showAlert:(NSString *)msg
{
    UIAlertView *alert = [ [UIAlertView alloc] initWithTitle:@"Info"
                                                     message:msg
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    [alert show];
}


-(IBAction)itemView:(id)sender
{    
    GRAlertView *alert;
    ////// Question
    alert = [[GRAlertView alloc] initWithTitle:NSLocalizedString(@"アイテム",nil)
                                       message:@"\n\n"
                                      delegate:self
                             cancelButtonTitle:@"OK"
                             otherButtonTitles:nil];
    alert.style = GRAlertStyleInfo;
    alert.tag=1;
    
    alert.animation = GRAlertAnimationBorder;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    fullItem=[userDefaults integerForKey:@"FULLITEM"];
    upItem=[userDefaults integerForKey:@"UPITEM"];

    
    fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    fullButton.frame = CGRectMake(20, 40, 30, 30);
    fullButton.titleLabel.text=@"";
    UIImage *fullImage = [UIImage imageNamed:@"缶_正面_みかんジュース"];
    [fullButton setBackgroundImage:fullImage forState:UIControlStateNormal];
    fullButton.tintColor=[UIColor clearColor];
    [fullButton addTarget:self action:@selector(fullImage)
         forControlEvents:UIControlEventTouchUpInside];
    
    fullLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 30, 15)];
    fullLabel.textColor=[UIColor darkGrayColor];
    fullLabel.backgroundColor=[UIColor clearColor];
    fullLabel.text= [NSString stringWithFormat:@"%d",fullItem];
    fullLabel.textAlignment=NSTextAlignmentCenter;
    fullLabel.font=labelFont;
    
    upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.frame = CGRectMake(90, 40, 30, 30);
    upButton.titleLabel.text=@"";
    UIImage *upImage = [UIImage imageNamed:@"carving_time_icon_32"];
    [upButton setBackgroundImage:upImage forState:UIControlStateNormal];
    upButton.tintColor=[UIColor lightGrayColor];
    [upButton addTarget:self action:@selector(upUp)
       forControlEvents:UIControlEventTouchUpInside];
    
    upLabel=[[UILabel alloc] initWithFrame:CGRectMake(90, 70, 30, 15)];
    upLabel.textColor=[UIColor darkGrayColor];
    upLabel.backgroundColor=[UIColor clearColor];
    upLabel.text=[NSString stringWithFormat:@"%d",upItem];
    upLabel.textAlignment=NSTextAlignmentCenter;
    upLabel.font=labelFont;
    
    bossButton = [UIButton buttonWithType:UIButtonTypeCustom];
    bossButton.frame = CGRectMake(160, 40, 30, 30);
    bossButton.titleLabel.text=@"";
    UIImage *bossImage = [UIImage imageNamed:@"penguin"];
    [bossButton setBackgroundImage:bossImage forState:UIControlStateNormal];
    bossButton.tintColor=[UIColor lightGrayColor];
    [bossButton addTarget:self action:@selector(bossAnimation)
         forControlEvents:UIControlEventTouchUpInside];
    
    bossLabel=[[UILabel alloc] initWithFrame:CGRectMake(160, 70, 30, 15)];
    bossLabel.textColor=[UIColor darkGrayColor];
    bossLabel.backgroundColor=[UIColor clearColor];
    bossLabel.text=@"∞";
    bossLabel.textAlignment=NSTextAlignmentCenter;
    bossLabel.font=labelFont;
    
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame = CGRectMake(230, 40, 30, 30);
    addButton.titleLabel.text=@"";
    UIImage *addImage = [UIImage imageNamed:@"shopping_cart"];
    [addButton setBackgroundImage:addImage forState:UIControlStateNormal];
    addButton.tintColor=[UIColor darkGrayColor];
    [addButton addTarget:self action:@selector(addPurchase)
        forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *addLabel=[[UILabel alloc] initWithFrame:CGRectMake(220, 70, 50, 15)];
    addLabel.textColor=[UIColor darkGrayColor];
    addLabel.backgroundColor=[UIColor clearColor];
    addLabel.text=NSLocalizedString(@"購入",nil);
    addLabel.textAlignment=NSTextAlignmentCenter;
    addLabel.font=labelFont;
    
    [alert addSubview:fullButton];
    [alert addSubview:fullLabel];
    [alert addSubview:upButton];
    [alert addSubview:upLabel];
    [alert addSubview:bossButton];
    [alert addSubview:bossLabel];
    [alert addSubview:addButton];
    [alert addSubview:addLabel];

    
    [alert show];
}
/*

- (void)bounceOutAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         item.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9, 0.9);
         item.alpha = 0.8;
     }
                     completion:^(BOOL finished){
                         [self bounceInAnimationStoped];
                     }];
}
- (void)bounceInAnimationStoped
{
    [UIView animateWithDuration:0.1 animations:
     ^(void){
         item.transform = CGAffineTransformScale(CGAffineTransformIdentity,1, 1);
         item
         .alpha = 1.0;
     }
                     completion:^(BOOL finished){
                         [self purchaseAnimationStoped];
                     }];
}
- (void)purchaseAnimationStoped
{
 
}*/

-(void)fullImage
{
    if(fullItem<1)
    {
        fullItem=0;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
        [userDefaults setInteger:fullItem forKey:@"FULLITEM"];
        [userDefaults synchronize];
        fullButton.enabled=FALSE;
        return;
    }
    
    if(FlagTime==0)
    {
        return;
    }
    
    for(int i=Image1Count;i<12;i++)
    {
        [self touchImage1];
    }
    
    for(int i=Image2Count;i<12;i++)
    {
        [self touchImage2];
    }
    
    for(int i=Image3Count;i<12;i++)
    {
        [self touchImage3];
    }
    
    for(int i=Image4Count;i<12;i++)
    {
        [self touchImage4];
    }
    
    for(int i=Image5Count;i<12;i++)
    {
        [self touchImage5];
    }
    
    for(int i=Image6Count;i<12;i++)
    {
        [self touchImage6];
    }
    
    fullItem=fullItem-1;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
    [userDefaults setInteger:fullItem forKey:@"FULLITEM"];
    [userDefaults synchronize];
    fullLabel.text=[NSString stringWithFormat:@"%d",fullItem];
}

-(void)upUp
{
    if(FlagTime==0)
    {
        return;
    }
    
    for(int i=0;i<10;i++)
    {
        [self levelUp];
    }
    
    if(upItem>1)
    {
        upItem=upItem-1;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
        [userDefaults setInteger:upItem forKey:@"UPITEM"];
        [userDefaults synchronize];
    }
    else
    {
        upItem=0;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];  // 取得
        [userDefaults setInteger:upItem forKey:@"UPITEM"];
        [userDefaults synchronize];
        upButton.enabled=false;
    }
    upLabel.text=[NSString stringWithFormat:@"%d",upItem];
}

/*******************************************************************
 関数名　　bossAnimation
 概要	 ボス客の画像をアニメーション表示する
 引数　　 なし
 戻り値	なし
 *******************************************************************/
-(void)bossAnimation
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    BossCount++;
    UIImageView *boss = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"penguin.png"]];
    
    int boss_move=rand()%6;
    int boss_move_x=0;
    
    // 移動先の座標を設定
    switch(boss_move)
    {
        case 0:
            boss_move_x=35;
            break;
        case 1:
            boss_move_x=80;
            break;
        case 2:
            boss_move_x=120;
            break;
        case 3:
            boss_move_x=160;
            break;
        case 4:
            boss_move_x=200;
            break;
        case 5:
            boss_move_x=240;
            break;
        default:
            break;
    }
    
    [boss setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y-5, 50, 50)];
    [self.view addSubview:boss];
    
    [UIView animateWithDuration:2.0
                     animations:^{boss.frame =CGRectOffset(boss.frame, boss_move_x, 0);}
                     completion:^(BOOL finished) {
                         
                         if(boss_move==0)
                         {
                             int temp=(Image1Count>=5)?5:Image1Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation1) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                         }
                         else if(boss_move==1)
                         {
                             int temp=(Image2Count>=5)?5:Image2Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation2) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                             
                         }
                         else if(boss_move==2)
                         {
                             int temp=(Image3Count>=5)?5:Image3Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation3) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                         }
                         else if(boss_move==3)
                         {
                             int temp=(Image4Count>=5)?5:Image4Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation4) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                         }
                         else if(boss_move==4)
                         {
                             int temp=(Image5Count>=5)?5:Image5Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation5) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                         }
                         else if(boss_move==5)
                         {
                             int temp=(Image6Count>=5)?5:Image6Count;
                             for(int i=0;i<temp;i++)
                             {
                                 [self performSelectorInBackground:@selector(deleteAnimation6) withObject:nil];
                                 [NSThread sleepForTimeInterval:(INTERVAL_TIME/2)];
                             }
                         }
                         
                         [UIView animateWithDuration:0.5
                                          animations:^{boss.frame =CGRectOffset(boss.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [boss removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　deleteAnimation1
 概要	 imageView1_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation1
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView1_1.hidden=YES;
    
    UIImageView *can1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_みかんジュース.png"]];
    [can1 setFrame:CGRectMake(42,119,37,42)];
    [self.view addSubview:can1];
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can1.alpha = 0.0;}
                     completion: ^(BOOL finished){can1.alpha = 0.0;[can1 removeFromSuperview];
                         [self deleteImage1];
                         if(Image1Count>=1)
                         {
                             sleep(0.2);
                             imageView1_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　deleteAnimation2
 概要	 imageView2_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation2
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView2_1.hidden=YES;
    
    UIImageView *can2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_トマトジュース.png"]];
    [can2 setFrame:CGRectMake(84,119,37,42)];
    [self.view addSubview:can2];
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can2.alpha = 0.0;}
                     completion: ^(BOOL finished){can2.alpha = 0.0;[can2 removeFromSuperview];
                         [self deleteImage2];
                         if(Image2Count>=1)
                         {
                             sleep(0.2);
                             imageView2_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　deleteAnimation3
 概要	 imageView3_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation3
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView3_1.hidden=YES;
    
    UIImageView *can3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コンポタ.png"]];
    [can3 setFrame:CGRectMake(124,119,37,42)];
    [self.view addSubview:can3];
    
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can3.alpha = 0.0;}
                     completion: ^(BOOL finished){can3.alpha = 0.0;[can3 removeFromSuperview];
                         [self deleteImage3];
                         if(Image3Count>=1)
                         {
                             sleep(0.2);
                             imageView3_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　deleteAnimation4
 概要	 imageView4_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation4
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView4_1.hidden=YES;
    
    UIImageView *can4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒー.png"]];
    [can4 setFrame:CGRectMake(160,119,37,42)];
    [self.view addSubview:can4];
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can4.alpha = 0.0;}
                     completion: ^(BOOL finished){can4.alpha = 0.0;[can4 removeFromSuperview];
                         [self deleteImage4];
                         if(Image4Count>=1)
                         {
                             sleep(0.2);
                             imageView4_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　deleteAnimation5
 概要	 imageView5_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation5
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView5_1.hidden=YES;
    
    UIImageView *can5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒーブラック.png"]];
    [can5 setFrame:CGRectMake(199,119,37,42)];
    [self.view addSubview:can5];
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can5.alpha = 0.0;}
                     completion: ^(BOOL finished){can5.alpha = 0.0;[can5 removeFromSuperview];
                         [self deleteImage5];
                         if(Image5Count>=1)
                         {
                             sleep(0.2);
                             imageView5_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　deleteAnimation6
 概要	 imageView6_1の点滅アニメーション
 引数　　  :なし
 *******************************************************************/
-(void)deleteAnimation6
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    imageView6_1.hidden=YES;
    
    UIImageView *can6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_葡萄ジュース.png"]];
    [can6 setFrame:CGRectMake(240,119,37,42)];
    [self.view addSubview:can6];
    
    [UIView animateWithDuration: IMG_ONOFF_INTERVAL
                          delay: 0.0
                        options: UIViewAnimationOptionAutoreverse | UIViewAnimationOptionRepeat
                     animations: ^{[UIView setAnimationRepeatCount:IMG_ONOFF_COUNT];
                         can6.alpha = 0.0;}
                     completion: ^(BOOL finished){can6.alpha = 0.0;[can6 removeFromSuperview];
                         [self deleteImage6];
                         if(Image6Count>=1)
                         {
                             sleep(0.2);
                             imageView6_1.hidden=NO;
                         }
                     }
     ];
}

/*******************************************************************
 関数名　　animation1
 概要	 客その1のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation1
{
    UIImageView *customer1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer1 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer1];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer1.frame =CGRectOffset(customer1.frame, 35, 0);}
                     completion:^(BOOL finished) {
                         [self deleteAnimation1];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer1.frame =CGRectOffset(customer1.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer1 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　animation2
 概要	 客その2のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation2
{
    UIImageView *customer2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer2 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer2];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer2.frame =CGRectOffset(customer2.frame, 80, 0);}
                     completion:^(BOOL finished) {
                         [self deleteAnimation2];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer2.frame =CGRectOffset(customer2.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer2 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　animation3
 概要	 客その3のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation3
{
    UIImageView *customer3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer3 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer3];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer3.frame =CGRectOffset(customer3.frame, 120, 0);}                     completion:^(BOOL finished) {
                         [self deleteAnimation3];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer3.frame =CGRectOffset(customer3.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer3 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　animation4
 概要	 客その4のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation4
{
    UIImageView *customer4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer4 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer4];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer4.frame =CGRectOffset(customer4.frame, 160, 0);}
                     completion:^(BOOL finished) {
                         [self deleteAnimation4];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer4.frame =CGRectOffset(customer4.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer4 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　animation5
 概要	 客その5のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation5
{
    UIImageView *customer5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer5 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer5];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer5.frame =CGRectOffset(customer5.frame, 200, 0);}                     completion:^(BOOL finished) {
                         [self deleteAnimation5];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer5.frame =CGRectOffset(customer5.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer5 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　animation6
 概要	 客その6のアニメーションを表示
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)animation6
{
    UIImageView *customer6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tux.png"]];
    [customer6 setFrame:CGRectMake(CUSTOMER_MAKE_X, CUSTOMER_MAKE_Y, CUSTOMER_SIZE_W, CUSTOMER_SIZE_H)];
    [self.view addSubview:customer6];
    
    [UIView animateWithDuration:CUSTOMER_COME_SPEED
                     animations:^{customer6.frame =CGRectOffset(customer6.frame, 240, 0);}
                     completion:^(BOOL finished) {
                         [self deleteAnimation6];
                         [UIView animateWithDuration:CUSTOMER_GO_SPEED
                                          animations:^{customer6.frame =CGRectOffset(customer6.frame, 320, 0);}
                                          completion:^(BOOL finished) {
                                              [customer6 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　startGame
 概要	 スタートボタンを押下された時の処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
- (IBAction)startGame:(id)sender
{
    if(FlagTime==1)                        //ゲーム動作時に押下された場合
    {
        [self pauseGame];
        return;
    }
    
    if(FlagPause==0)                       //ポーズ中でない場合
    {
        [self viewDidLoad];                //viewDidLoadメソッドを呼び出し変数を初期化する
    }
    
    [self beforeRunGame];
}

/*******************************************************************
 関数名　　pauseGame
 概要	 ゲーム動作中のポーズ処理
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)pauseGame
{
    self.startButton.enabled=true;
    self.stopButton.enabled=false;
    
    FlagPause=1;                       //ポーズ判定ON
    TempTime=TimeDif;                  //経過時間を退避
    [timer invalidate];                //タイム計測を止める
    FlagTime=0;                        //ゲーム動作を止める
    
    sleep(2);
}

/*******************************************************************
 関数名　　displayMenu
 概要	 TOPボタン押下時の画面遷移処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
- (IBAction) displayMenu:(id)sender{
    //ゲーム動作中にメニューボタンを押下された場合
    if(FlagTime==1 || FlagPause==1)
    {
        [self pauseGame];
        
        //アラートを表示しalertViewclickedButtonAtIndexメソッドに処理を移譲
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:NSLocalizedString(@"確認ダイアログ",nil)
                                  message:NSLocalizedString(@"ゲームを中止してメニュー画面に戻ります。よろしいですか？" ,nil)delegate:self
                                  cancelButtonTitle:NSLocalizedString(@"いいえ",nil)
                                  otherButtonTitles:NSLocalizedString(@"はい",nil),nil
                                  ];
        [alertView show];
    }
    
    else
    {        
        [self.view removeFromSuperview];
        
        sleep(2);
        
        menuView=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        [self.view addSubview:menuView.view];
        [menuView viewDidLoad];
    }
}


/*******************************************************************
 関数名　　alertView
 概要	 アラートのボタン（はい、いいえetc)押下時の処理
 　　　　　アラートはstartGameメソッド内で呼び出される
 引数　　 (UIAlertView*)alertViewclickedButtonAtIndex    :呼び出し元のAlertView
 (NSInteger)buttonIndex                         :クリックされたアラートのボタンのインデックス
 戻り値	なし
 *******************************************************************/
-(void)alertView:(UIAlertView*)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:                 //「いいえ」を選択した場合はゲーム再開
            if(alertView.tag==1)
            {
                return;
            }
            [self beforeRunGame];
            break;
        case 1:                 //「はい」を選択した場合はメニュー画面を表示する
        {
            [self.view removeFromSuperview];
            
            sleep(2);
            
            menuView=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            [self.view addSubview:menuView.view];
            [menuView viewDidLoad];
            
            break;
        }
        default:
            break;
    }
}

/*******************************************************************
 関数名　　onTimer
 概要	 ゲーム経過時間の取得と、時間に応じた難易度や時給の設定
 引数　　 (NSTimer*)timerParameter
 戻り値	なし
 *******************************************************************/
-(void)onTimer:(NSTimer*)timerParameter {
    
    nowDate=[NSDate date];                                  //現在時刻を取得
    TimeDif=[nowDate timeIntervalSinceDate:(stDate)];       //ゲーム開始時刻との差分を代入
    TimeDif+=TempTime;
    //ポーズ時に退避させたタイムを加算
    
    if(TimeDif%5==0)
    {
        [self levelUp];
    }
    
    
    if(GameLevel<10)
    {
        if(TimeDif%10==0)
        {
            [self bossAnimation];
        }
    }
    else if(GameLevel<20)
    {
        if(GameLevel>10 && TimeDif%8==0)
        {
            [self bossAnimation];
        }
    }
    else
    {
        if(GameLevel>20 && TimeDif%5==0)
        {
            [self bossAnimation];
        }
    }
    
    //ゲーム進行中にメニューボタンにより中止した場合の処理
    if(FlagTime==0)
    {
        [timer invalidate];                                     //時刻の取得中止
    }
}

/*******************************************************************
 関数名　　levelUp
 概要	 ゲームの難易度と時給表示の変更
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)levelUp
{
    if(GameLevel<MAX_LEVEL)
    {
        GameLevel++;
        HourlyWages+=100;
        [self pointDisplay];
    }
}

/*******************************************************************
 関数名　　beforeRunGame
 概要	 ゲーム開始前の時間取得操作など
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)beforeRunGame
{
    self.startButton.enabled=false;
    self.stopButton.enabled=true;
    
    FlagTime=1;
    
    stDate = [[NSDate alloc] init];     //ゲーム開始時刻
    nowDate = [[NSDate alloc] init];    //現在時刻
    
    //1秒間隔で時間を取得
    timer = [NSTimer scheduledTimerWithTimeInterval:(1.0)
                                             target:self
                                           selector:@selector(onTimer:)
                                           userInfo:nil
                                            repeats:YES];
    
    //ゲームロジックをバックグランドで実行
    [self performSelectorInBackground:@selector(runGame) withObject:nil];
}


/*******************************************************************
 関数名　　runGame
 概要	 ゲーム開始後、難易度に応じて画像を非表示にする
 引数　　 なし
 戻り値	なし
 *******************************************************************/
- (void)runGame
{
    //UserDefaultsの取得
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //ハイスコア1~3のデータを辞書から取得
    int score1 = [userDefaults integerForKey:@"KEY_SCORE1"];
    int score2 = [userDefaults integerForKey:@"KEY_SCORE2"];
    int score3 = [userDefaults integerForKey:@"KEY_SCORE3"];
    
    //範囲外のデータだった場合は700に設定
    score1=(score1>=700 && score1<=10700)?score1:1500;
    score2=(score2>=700 && score2<=10700)?score2:1500;
    score3=(score3>=700 && score3<=10700)?score3:1500;
    
    //平均値を求める
    PastAverage=(score1+score2+score3)/3;
    
    unsigned int resTime=0;
    unsigned int resTime2=0;
    unsigned int bias=0;
    
    //過去の成績によってバイアスを設ける
    if(PastAverage<=900)
    {
        bias=1.0;
    }
    else if(PastAverage<=1200)
    {
        bias=0.5;
    }
    else if(PastAverage<=1500)
    {
        bias=0.25;
    }
    else if(PastAverage<=1800)
    {
        bias=0.125;
    }
    
    while(FlagTime!=0)
    {
        if(GameLevel<5)
        {
            resTime=(1.15+bias-GameLevel*0.025);
            //            resTime2=0;
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                sleep(1);
            }
            
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            sleep(resTime);
        }
        else if(GameLevel<10)
        {
            resTime=(1.025+bias-GameLevel*0.0025);
            resTime2=0;
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                resTime*=2;
                resTime2=1;
            }
            
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                sleep(1);
            }
            //            sleep(resTime2);
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                sleep(1);
            }
            //            sleep(resTime2);
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            sleep(resTime);
        }
        else
        {
            resTime=(1.01+bias-GameLevel*0.0002);
            resTime2=0;
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                resTime*=2;
                resTime2=1;
            }
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                sleep(1);
            }
            //            sleep(resTime2);
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            if(Image1Count<=2 || Image2Count <=2 || Image3Count<=2 || Image4Count<=2 || Image5Count<=2 || Image6Count<=2)
            {
                sleep(1);
            }
            //            sleep(resTime2);
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            [self performSelectorInBackground:@selector(randomDelete) withObject:nil];
            [NSThread sleepForTimeInterval:(INTERVAL_TIME)];
            sleep(resTime);
        }
    }
}

/*******************************************************************
 関数名　　rightButtonClick
 概要	 画面下部スクロール部右ボタンクリック時の処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
- (IBAction)rightButtonClick:(id)sender
{
    ++PatternType;
    
    [self dispTabImage:PatternType];
}

/*******************************************************************
 関数名　　leftButtonClick
 概要	 画面下部スクロール部右ボタンクリック時の処理
 引数　　 (id)sender            :アクションの呼び出し元オブジェクト
 戻り値	(IBAction)            :xibにアクションを認識させるキーワード　コンパイル時にvoid変換
 *******************************************************************/
- (IBAction)leftButtonClick:(id)sender
{
    --PatternType;
    
    [self dispTabImage:PatternType];
}

/*******************************************************************
 関数名　　touchesBegan
 概要	 画面下部スクロール部フリック時の始点座標取得
 引数　　 (NSSet *)touches withEvent
 　　　　 (UIEvent *)event
 戻り値	なし
 *******************************************************************/
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touchBegan = [touches anyObject];
    tBegan = [ touchBegan locationInView: self.view ];
}

/*******************************************************************
 関数名　　touchesEnded
 概要	 画面下部スクロール部フリック時の終点座標取得
 　　　　　上フリック操作時のアイテム補充処理
 引数　　 (NSSet *)touches withEvent
 　　　　 (UIEvent *)event
 戻り値	なし
 *******************************************************************/
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch * touchEnded = [touches anyObject];
    tEnded = [ touchEnded locationInView: self.view ];
    
    if(tBegan.y<380)
    {
        return;
    }
    
    if(tBegan.x<74 || tBegan.x>246)
    {
        return;
    }
    
    NSInteger distanceHorizontal = ABS( tEnded.x - tBegan.x );
    NSInteger distanceVertical = ABS( tEnded.y - tBegan.y );
    
    if ( distanceHorizontal < distanceVertical && tEnded.y < tBegan.y)
    {
        if(tBegan.x>74 && tBegan.x<130)
        {
            if(PatternType==0)
            {
                [self touchAnimation1];
            }
            else if(PatternType==1)
            {
                [self touchAnimation4];
            }
            else if(PatternType==2)
            {
                [self touchAnimation7];
            }
            else if(PatternType==3)
            {
                [self touchAnimation10];
            }
        }
        
        if(tBegan.x >132 && tBegan.x<188)
        {
            if(PatternType==0)
            {
                [self touchAnimation2];
            }
            else if(PatternType==1)
            {
                [self touchAnimation5];
            }
            else if(PatternType==2)
            {
                [self touchAnimation8];
            }
            else if(PatternType==3)
            {
                [self touchAnimation11];
            }
        }
        
        if(tBegan.x >190 && tBegan.x<246)
        {
            if(PatternType==0)
            {
                [self touchAnimation3];
            }
            else if(PatternType==1)
            {
                [self touchAnimation6];
            }
            else if(PatternType==2)
            {
                [self touchAnimation9];
            }
            else if(PatternType==3)
            {
                [self touchAnimation12];
            }
        }
    }
}

/*******************************************************************
 関数名　　dispTabImage
 概要	 引数PatternTypeに応じて画面下部スクロール部の表示画像を変更する
 引数　　 (int)PatternType              :画面表示パターン
 戻り値	なし
 *******************************************************************/
- (void)dispTabImage:(int)type
{
    self.viewImage1.image=[UIImage imageNamed:imageStr[type]];
    self.viewImage2.image=[UIImage imageNamed:imageStr[type+1]];
    self.viewImage3.image=[UIImage imageNamed:imageStr[type+2]];
    
    if(type==0)
    {
        self.leftButton.enabled=false;
        self.rightButton.enabled=true;
    }
    
    else if(type==1)
    {
        self.leftButton.enabled=true;
        self.rightButton.enabled=true;
    }
    
    else if(type==2)
    {
        self.leftButton.enabled=true;
        self.rightButton.enabled=true;
    }
    
    else if(type==3)
    {
        self.leftButton.enabled=true;
        self.rightButton.enabled=false;
    }
}

/*******************************************************************
 関数名　　pointDisplay
 概要	 時給表示用ラベルにグローバル変数HourlyWagesに設定された値を表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)pointDisplay
{
    self.scoreLabel.text=[NSString stringWithFormat:@"%d",HourlyWages];
}

/*******************************************************************
 関数名　　randomDelete
 概要	 ランダムにボトル画像表示を削除
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)randomDelete
{
    if(FlagTime==0)
    {
        return;
    }
    
    int temp=rand()%6;
    switch (temp) {
        case 0:
            [self animation1];
            break;
        case 1:
            [self animation2];
            break;
        case 2:
            [self animation3];
            break;
        case 3:
            [self animation4];
            break;
        case 4:
            [self animation5];
            break;
        case 5:
            [self animation6];
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　gameOver
 概要	 ゲームオーバー時の諸処理
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)gameOver
{
    FlagTime=0;
    FlagPause=0;
    [timer invalidate];
    resultLabel.hidden=NO;
    
    int array[3]={HourlyWages,BossCount,TouchCount};
    
    [NSThread sleepForTimeInterval:1.0];
    sleep(1);
    
    scoreView=[[ScoreViewController alloc]initWithNibName:@"ScoreViewController" bundle:nil];
//    [item removeFromSuperview];
    item.alpha=0;
    [self.view addSubview:scoreView.view];
    
    // 初期位置を決める
    CGPoint p;
    if (self.interfaceOrientation == UIInterfaceOrientationPortrait ||
        self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        p = CGPointMake(0.0, CGRectGetHeight([[UIScreen mainScreen] applicationFrame]));
    } else {
        p = CGPointMake(0.0, CGRectGetWidth([[UIScreen mainScreen] applicationFrame]));
    }
    CGRect r = scoreView.view.frame;
    r.origin = p;
    [scoreView.view setFrame:r];
    
    
    // Animation
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    CGRect newRect = scoreView.view.frame;
    newRect.origin = CGPointMake(0, 0);
    [scoreView.view setFrame:newRect];
    [UIView commitAnimations];
    
    //    [self.view addSubview:scoreView.view];
    [scoreView displayScore:array];
    
    //NSUserDefaultsからデータを読み込む
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int score1 = [userDefaults integerForKey:@"KEY_SCORE1"];    //No.1スコアの取得
    int score2 = [userDefaults integerForKey:@"KEY_SCORE2"];    //No.2スコアの取得
    int score3 = [userDefaults integerForKey:@"KEY_SCORE3"];    //No.3スコアの取得
    
    score3=score2;                      //score3に旧No.2スコアを代入
    score2=score1;
    score1=HourlyWages;
    
    //前3ゲームのスコアを記録する
    [userDefaults setInteger:score1 forKey:@"KEY_SCORE1"];
    [userDefaults setInteger:score2 forKey:@"KEY_SCORE2"];
    [userDefaults setInteger:score3 forKey:@"KEY_SCORE3"];
    
    //データ保存
    [userDefaults synchronize];
    
    sleep(1);
    
    self.startButton.enabled=true;
    self.stopButton.enabled=false;
}


/*******************************************************************
 関数名　　touchAnimation1
 概要	 画面下部スクロール左画像から1種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation1
{
    if(FlagTime==0 ||Image1Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image1Count;
    
    UIImageView *can1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_みかんジュース"]];
    [can1 setFrame:CGRectMake(74, 400, 41, 46)];
    [self.view addSubview:can1];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can1.frame =CGRectOffset(can1.frame, -64,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can1.frame =CGRectOffset(can1.frame, 3*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage1];
                                              [can1 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation2
 概要	 画面下部スクロール中央画像から2種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation2
{
    if(FlagTime==0 ||Image2Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image2Count;
    
    UIImageView *can2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_トマトジュース"]];
    [can2 setFrame:CGRectMake(132, 400, 41, 46)];
    [self.view addSubview:can2];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can2.frame =CGRectOffset(can2.frame, -70,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can2.frame =CGRectOffset(can2.frame, 2*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage2];
                                              [can2 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation3
 概要	 画面下部スクロール右画像から3種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation3
{
    if(FlagTime==0 ||Image3Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image3Count;
    
    UIImageView *can3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コンポタ"]];
    [can3 setFrame:CGRectMake(190, 400, 41, 46)];
    [self.view addSubview:can3];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can3.frame =CGRectOffset(can3.frame, -77,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can3.frame =CGRectOffset(can3.frame, 1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage3];
                                              [can3 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation4
 概要	 画面下部スクロール左画像から2種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation4
{
    if(FlagTime==0 ||Image2Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image2Count;
    
    UIImageView *can2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_トマトジュース"]];
    [can2 setFrame:CGRectMake(74, 400, 41, 46)];
    [self.view addSubview:can2];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can2.frame =CGRectOffset(can2.frame, -6,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can2.frame =CGRectOffset(can2.frame, 2*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage2];
                                              [can2 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation5
 概要	 画面下部スクロール中央画像から3種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation5
{
    if(FlagTime==0 ||Image3Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image3Count;
    
    UIImageView *can3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コンポタ"]];
    [can3 setFrame:CGRectMake(132, 400, 41, 46)];
    [self.view addSubview:can3];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can3.frame =CGRectOffset(can3.frame, -19,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can3.frame =CGRectOffset(can3.frame, 1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage3];
                                              [can3 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation6
 概要	 画面下部スクロール右画像から4種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation6
{
    if(FlagTime==0 ||Image4Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image4Count;
    
    UIImageView *can4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒー"]];
    [can4 setFrame:CGRectMake(190, 400, 41, 46)];
    [self.view addSubview:can4];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can4.frame =CGRectOffset(can4.frame, -23,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can4.frame =CGRectOffset(can4.frame, -1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage4];
                                              [can4 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation7
 概要	 画面下部スクロール左画像から3種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation7
{
    if(FlagTime==0 ||Image3Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image3Count;
    
    UIImageView *can3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コンポタ"]];
    [can3 setFrame:CGRectMake(74, 400, 41, 46)];
    [self.view addSubview:can3];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can3.frame =CGRectOffset(can3.frame, 39,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can3.frame =CGRectOffset(can3.frame, 1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage3];
                                              [can3 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation8
 概要	 画面下部スクロール中央画像から4種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation8
{
    if(FlagTime==0 ||Image4Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image4Count;
    
    UIImageView *can4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒー"]];
    [can4 setFrame:CGRectMake(132, 400, 41, 46)];
    [self.view addSubview:can4];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can4.frame =CGRectOffset(can4.frame, 35,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can4.frame =CGRectOffset(can4.frame, -1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage4];
                                              [can4 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation9
 概要	 画面下部スクロール右画像から5種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation9
{
    if(FlagTime==0 ||Image5Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image5Count;
    
    UIImageView *can5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒーブラック"]];
    [can5 setFrame:CGRectMake(190, 400, 41, 46)];
    [self.view addSubview:can5];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can5.frame =CGRectOffset(can5.frame, 27,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can5.frame =CGRectOffset(can5.frame, -2*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage5];
                                              [can5 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation10
 概要	 画面下部スクロール左画像から4種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation10
{
    if(FlagTime==0 ||Image4Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image4Count;
    
    UIImageView *can4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒー"]];
    [can4 setFrame:CGRectMake(74, 400, 41, 46)];
    [self.view addSubview:can4];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can4.frame =CGRectOffset(can4.frame, 93,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can4.frame =CGRectOffset(can4.frame, -1*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage4];
                                              [can4 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation11
 概要	 画面下部スクロール中央画像から5種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation11
{
    if(FlagTime==0 ||Image5Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image5Count;
    
    UIImageView *can5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_コーヒーブラック"]];
    [can5 setFrame:CGRectMake(132, 400, 41, 46)];
    [self.view addSubview:can5];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can5.frame =CGRectOffset(can5.frame, 85,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can5.frame =CGRectOffset(can5.frame, -2*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage5];
                                              [can5 removeFromSuperview];
                                          }];  }];
}

/*******************************************************************
 関数名　　touchAnimation12
 概要	 画面下部スクロール右画像から6種類目の缶補充アニメーション
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)touchAnimation12
{
    if(FlagTime==0 ||Image6Count==12)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    int temp=11-Image6Count;
    
    UIImageView *can6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"缶_立体_葡萄ジュース"]];
    [can6 setFrame:CGRectMake(190, 400, 41, 46)];
    [self.view addSubview:can6];
    
    [UIView animateWithDuration:CAN_SPEED
                     animations:^{can6.frame =CGRectOffset(can6.frame, 79,-75);}
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:CAN_SPEED
                                          animations:^{can6.frame =CGRectOffset(can6.frame, -3*temp, -20*temp);}
                                          completion:^(BOOL finished) {
                                              [self touchImage6];
                                              [can6 removeFromSuperview];
                                          }];  }];
}




/*******************************************************************
 関数名　　deleteImage1
 概要	 1種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage1
{
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image1Count) {
        case 12:
            imageView1_12.hidden=YES;
            if(Image1Count==12)
            {
                Image1Count--;
                break;
            }
        case 11:
            imageView1_11.hidden=YES;
            if(Image1Count==11)
            {
                Image1Count--;
                break;
            }
        case 10:
            imageView1_10.hidden=YES;
            if(Image1Count==10)
            {
                Image1Count--;
                break;
            }
        case 9:
            imageView1_9.hidden=YES;
            if(Image1Count==9)
            {
                Image1Count--;
                break;
            }
        case 8:
            imageView1_8.hidden=YES;
            if(Image1Count==8)
            {
                Image1Count--;
                break;
            }
        case 7:
            imageView1_7.hidden=YES;
            if(Image1Count==7)
            {
                Image1Count--;
                break;
            }
        case 6:
            imageView1_6.hidden=YES;
            if(Image1Count==6)
            {
                Image1Count--;
                break;
            }
        case 5:
            imageView1_5.hidden=YES;
            if(Image1Count==5)
            {
                Image1Count--;
                break;
            }
        case 4:
            imageView1_4.hidden=YES;
            if(Image1Count==4)
            {
                Image1Count--;
                break;
            }
        case 3:
            imageView1_3.hidden=YES;
            if(Image1Count==3)
            {
                Image1Count--;
                break;
            }
        case 2:
            imageView1_2.hidden=YES;
            if(Image1Count==2)
            {
                Image1Count--;
                break;
            }
        case 1:
            imageView1_1.hidden=YES;
            Image1Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　deleteImage2
 概要	 2種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage2
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image2Count) {
        case 12:
            imageView2_12.hidden=YES;
            if(Image2Count==12)
            {
                Image2Count--;
                break;
            }
        case 11:
            imageView2_11.hidden=YES;
            if(Image2Count==11)
            {
                Image2Count--;
                break;
            }
        case 10:
            imageView2_10.hidden=YES;
            if(Image2Count==10)
            {
                Image2Count--;
                break;
            }
        case 9:
            imageView2_9.hidden=YES;
            if(Image2Count==9)
            {
                Image2Count--;
                break;
            }
        case 8:
            imageView2_8.hidden=YES;
            if(Image2Count==8)
            {
                Image2Count--;
                break;
            }
        case 7:
            imageView2_7.hidden=YES;
            if(Image2Count==7)
            {
                Image2Count--;
                break;
            }
        case 6:
            imageView2_6.hidden=YES;
            if(Image2Count==6)
            {
                Image2Count--;
                break;
            }
        case 5:
            imageView2_5.hidden=YES;
            if(Image2Count==5)
            {
                Image2Count--;
                break;
            }
        case 4:
            imageView2_4.hidden=YES;
            if(Image2Count==4)
            {
                Image2Count--;
                break;
            }
        case 3:
            imageView2_3.hidden=YES;
            //            imageView2_10.hidden=YES;
            if(Image2Count==3)
            {
                Image2Count--;
                break;
            }
        case 2:
            imageView2_2.hidden=YES;
            //            imageView2_11.hidden=YES;
            if(Image2Count==2)
            {
                Image2Count--;
                break;
            }
        case 1:
            imageView2_1.hidden=YES;
            //            imageView2_12.hidden=YES;
            Image2Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　deleteImage3
 概要	 3種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage3
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image3Count) {
        case 12:
            imageView3_12.hidden=YES;
            if(Image3Count==12)
            {
                Image3Count--;
                break;
            }
        case 11:
            imageView3_11.hidden=YES;
            if(Image3Count==11)
            {
                Image3Count--;
                break;
            }
        case 10:
            imageView3_10.hidden=YES;
            if(Image3Count==10)
            {
                Image3Count--;
                break;
            }
        case 9:
            imageView3_9.hidden=YES;
            if(Image3Count==9)
            {
                Image3Count--;
                break;
            }
        case 8:
            imageView3_8.hidden=YES;
            if(Image3Count==8)
            {
                Image3Count--;
                break;
            }
        case 7:
            imageView3_7.hidden=YES;
            if(Image3Count==7)
            {
                Image3Count--;
                break;
            }
        case 6:
            imageView3_6.hidden=YES;
            if(Image3Count==6)
            {
                Image3Count--;
                break;
            }
        case 5:
            imageView3_5.hidden=YES;
            if(Image3Count==5)
            {
                Image3Count--;
                break;
            }
        case 4:
            imageView3_4.hidden=YES;
            if(Image3Count==4)
            {
                Image3Count--;
                break;
            }
        case 3:
            imageView3_3.hidden=YES;
            if(Image3Count==3)
            {
                Image3Count--;
                break;
            }
        case 2:
            imageView3_2.hidden=YES;
            if(Image3Count==2)
            {
                Image3Count--;
                break;
            }
        case 1:
            imageView3_1.hidden=YES;
            Image3Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　deleteImage4
 概要	 4種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage4
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image4Count) {
        case 12:
            imageView4_12.hidden=YES;
            if(Image4Count==12)
            {
                Image4Count--;
                break;
            }
        case 11:
            imageView4_11.hidden=YES;
            if(Image4Count==11)
            {
                Image4Count--;
                break;
            }
        case 10:
            imageView4_10.hidden=YES;
            if(Image4Count==10)
            {
                Image4Count--;
                break;
            }
        case 9:
            imageView4_9.hidden=YES;
            if(Image4Count==9)
            {
                Image4Count--;
                break;
            }
        case 8:
            imageView4_8.hidden=YES;
            if(Image4Count==8)
            {
                Image4Count--;
                break;
            }
        case 7:
            imageView4_7.hidden=YES;
            if(Image4Count==7)
            {
                Image4Count--;
                break;
            }
        case 6:
            imageView4_6.hidden=YES;
            if(Image4Count==6)
            {
                Image4Count--;
                break;
            }
        case 5:
            imageView4_5.hidden=YES;
            if(Image4Count==5)
            {
                Image4Count--;
                break;
            }
        case 4:
            imageView4_4.hidden=YES;
            if(Image4Count==4)
            {
                Image4Count--;
                break;
            }
        case 3:
            imageView4_3.hidden=YES;
            if(Image4Count==3)
            {
                Image4Count--;
                break;
            }
        case 2:
            imageView4_2.hidden=YES;
            if(Image4Count==2)
            {
                Image4Count--;
                break;
            }
        case 1:
            imageView4_1.hidden=YES;
            Image4Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　deleteImage5
 概要	 5種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage5
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image5Count) {
        case 12:
            imageView5_12.hidden=YES;
            if(Image5Count==12)
            {
                Image5Count--;
                break;
            }
        case 11:
            imageView5_11.hidden=YES;
            if(Image5Count==11)
            {
                Image5Count--;
                break;
            }
        case 10:
            imageView5_10.hidden=YES;
            if(Image5Count==10)
            {
                Image5Count--;
                break;
            }
        case 9:
            imageView5_9.hidden=YES;
            if(Image5Count==9)
            {
                Image5Count--;
                break;
            }
        case 8:
            imageView5_8.hidden=YES;
            if(Image5Count==8)
            {
                Image5Count--;
                break;
            }
        case 7:
            imageView5_7.hidden=YES;
            if(Image5Count==7)
            {
                Image5Count--;
                break;
            }
        case 6:
            imageView5_6.hidden=YES;
            if(Image5Count==6)
            {
                Image5Count--;
                break;
            }
        case 5:
            imageView5_5.hidden=YES;
            if(Image5Count==5)
            {
                Image5Count--;
                break;
            }
        case 4:
            imageView5_4.hidden=YES;
            if(Image5Count==4)
            {
                Image5Count--;
                break;
            }
        case 3:
            imageView5_3.hidden=YES;
            if(Image5Count==3)
            {
                Image5Count--;
                break;
            }
        case 2:
            imageView5_2.hidden=YES;
            if(Image5Count==2)
            {
                Image5Count--;
                break;
            }
        case 1:
            imageView5_1.hidden=YES;
            Image5Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　deleteImage6
 概要	 6種類目の画像を順次非表示にする
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
-(void)deleteImage6
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch (Image6Count) {
        case 12:
            imageView6_12.hidden=YES;
            if(Image6Count==12)
            {
                Image6Count--;
                break;
            }
        case 11:
            imageView6_11.hidden=YES;
            if(Image6Count==11)
            {
                Image6Count--;
                break;
            }
        case 10:
            imageView6_10.hidden=YES;
            if(Image6Count==10)
            {
                Image6Count--;
                break;
            }
        case 9:
            imageView6_9.hidden=YES;
            if(Image6Count==9)
            {
                Image6Count--;
                break;
            }
        case 8:
            imageView6_8.hidden=YES;
            if(Image6Count==8)
            {
                Image6Count--;
                break;
            }
        case 7:
            imageView6_7.hidden=YES;
            if(Image6Count==7)
            {
                Image6Count--;
                break;
            }
        case 6:
            imageView6_6.hidden=YES;
            if(Image6Count==6)
            {
                Image6Count--;
                break;
            }
        case 5:
            imageView6_5.hidden=YES;
            if(Image6Count==5)
            {
                Image6Count--;
                break;
            }
        case 4:
            imageView6_4.hidden=YES;
            if(Image6Count==4)
            {
                Image6Count--;
                break;
            }
        case 3:
            imageView6_3.hidden=YES;
            if(Image6Count==3)
            {
                Image6Count--;
                break;
            }
        case 2:
            imageView6_2.hidden=YES;
            if(Image6Count==2)
            {
                Image6Count--;
                break;
            }
        case 1:
            imageView6_1.hidden=YES;
            Image6Count--;
            [self gameOver];
        case 0:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage1
 概要	 1種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage1
{
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    TouchCount++;
    
    switch(Image1Count)
    {
        case 0:imageView1_1.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 1:imageView1_2.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 2:imageView1_3.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 3:imageView1_4.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 4:imageView1_5.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 5:imageView1_6.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 6:imageView1_7.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 7:imageView1_8.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 8:imageView1_9.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 9:imageView1_10.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 10:imageView1_11.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 11:imageView1_12.hidden=NO;
            Image1Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage2
 概要	 2種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage2
{
    TouchCount++;
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch(Image2Count)
    {
        case 0:imageView2_1.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 1:imageView2_2.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 2:imageView2_3.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 3:imageView2_4.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 4:imageView2_5.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 5:imageView2_6.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 6:imageView2_7.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 7:imageView2_8.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 8:imageView2_9.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 9:imageView2_10.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 10:imageView2_11.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 11:imageView2_12.hidden=NO;
            Image2Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage3
 概要	 3種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage3
{
    TouchCount++;
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch(Image3Count)
    {
        case 0:imageView3_1.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 1:imageView3_2.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 2:imageView3_3.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 3:imageView3_4.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 4:imageView3_5.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 5:imageView3_6.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 6:imageView3_7.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 7:imageView3_8.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 8:imageView3_9.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 9:imageView3_10.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 10:imageView3_11.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 11:imageView3_12.hidden=NO;
            Image3Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage4
 概要	 4種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage4
{
    TouchCount++;
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch(Image4Count)
    {
        case 0:imageView4_1.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 1:imageView4_2.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 2:imageView4_3.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 3:imageView4_4.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 4:imageView4_5.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 5:imageView4_6.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 6:imageView4_7.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 7:imageView4_8.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 8:imageView4_9.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 9:imageView4_10.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 10:imageView4_11.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 11:imageView4_12.hidden=NO;
            Image4Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage5
 概要	 5種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage5
{
    TouchCount++;
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch(Image5Count)
    {
        case 0:imageView5_1.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 1:imageView5_2.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 2:imageView5_3.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 3:imageView5_4.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 4:imageView5_5.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 5:imageView5_6.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 6:imageView5_7.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 7:imageView5_8.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 8:imageView5_9.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 9:imageView5_10.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 10:imageView5_11.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 11:imageView5_12.hidden=NO;
            Image5Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

/*******************************************************************
 関数名　　touchImage6
 概要	 6種類目の画像を順次表示する
 引数　　　なし
 戻り値　　なし
 *******************************************************************/
- (void)touchImage6
{
    TouchCount++;
    
    if(FlagTime==0)            //ゲームスタート時以外は何もしない
    {
        return;
    }
    
    switch(Image6Count)
    {
        case 0:imageView6_1.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 1:imageView6_2.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 2:imageView6_3.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 3:imageView6_4.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 4:imageView6_5.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 5:imageView6_6.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 6:imageView6_7.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 7:imageView6_8.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 8:imageView6_9.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 9:imageView6_10.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 10:imageView6_11.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 11:imageView6_12.hidden=NO;
            Image6Count++;
            [self pointDisplay];
            break;
        case 12:
            break;
        default:
            break;
    }
}

@end

