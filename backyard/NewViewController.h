//
//  NewViewController.h
//  backyard
//
//  Created by 羽野 真悟 on 13/02/25.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseManager.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuViewController.h"
#import "ScoreViewController.h"
#import "GRAlertView.h"
#import "LeveyPopListView.h"


#ifdef INTERVAL_TIME
#undef INTERVAL_TIME
#endif
#define INTERVAL_TIME 0.6            //スレッド間のインターバル 0.2以上だとゲームの難易度が簡単すぎる

#define MAX_LEVEL 999                    //ゲームの最大レベル
#define CUSTOMER_MAKE_X 0               //客フレーム生成時X座標
#define CUSTOMER_MAKE_Y 70              //客フレーム生成時Y座標
#define CUSTOMER_SIZE_H 45              //客フレーム縦サイズ
#define CUSTOMER_SIZE_W 45              //客フレーム横サイズ
#define IMG_ONOFF_COUNT 1               //缶購入時の缶の点滅回数 2以上だとゲームオーバー時に不具合
#define IMG_ONOFF_INTERVAL 0.05         //缶購入時の缶の点滅間隔
#define CUSTOMER_COME_SPEED 1.0         //客アニメーションのフレームインのスピード
#define CUSTOMER_GO_SPEED 0.5           //客アニメーションのフレームアウトのスピード
#define CAN_SPEED 0.05                  //補充する缶のアニメーションスピード

@interface NewViewController : UIViewController<UIAlertViewDelegate,UIApplicationDelegate,LeveyPopListViewDelegate>

{
    //グローバル変数の宣言
    int Image1Count;        //1種類目の画像カウント変数
    int Image2Count;        //2種類目の画像カウント変数
    int Image3Count;        //3種類目の画像カウント変数
    int Image4Count;        //4種類目の画像カウント変数
    int Image5Count;        //5種類目の画像カウント変数
    int Image6Count;        //6種類目の画像カウント変数
    int FlagTime;           //ゲーム時間の判定用変数
    int PatternType;        //スクロールのイメージパターン用変数
    int GameLevel;          //ゲームの難易度用変数
    int HourlyWages;        //時給用変数
    int TimeDif;            //タイム計測用変数
    int TempTime;           //ポーズ時タイム加算用変数
    int FlagPause;          //ポーズ判定用変数
    int BossCount;          //ボス出現回数
    int TouchCount;         //補充回数
    int PastAverage;        //過去の平均スコア
    float IntervalTime;     //スレッド間インターバルタイム用変数
    int flagItem;
    int upItem;
    int fullItem;
    int bossItem;
    int firstFlag;
    
    UIFont *labelFont;
    UIButton *fullButton;
    UILabel *fullLabel;
    UIButton *upButton;
    UILabel *upLabel;
    UIButton *bossButton;
    UILabel *bossLabel;
    

    //画面で使用するオブジェクト
    IBOutlet UIButton *rightButton;     //画面下部スクロール部右ボタン
    IBOutlet UIButton *leftButton;      //画面下部スクロール部左ボタン
    IBOutlet UIImageView *viewImage1;   //画面下部スクロール左画像
    IBOutlet UIImageView *viewImage2;   //画面下部スクロール中央画像
    IBOutlet UIImageView *viewImage3;   //画面下部スクロール右画像
    IBOutlet UIButton *startButton;     //ゲームスタートボタン
    IBOutlet UIButton *stopButton;      //ゲームストップボタン
    IBOutlet UILabel *scoreLabel;       //時給表示用ラベル
    IBOutlet UILabel *resultLabel;      //ゲームオーバー表示用ラベル
    IBOutlet UIView *item;
    IBOutlet UIView *purchaseView;


    
    //メソッド内で使用する変数
    CGPoint tBegan, tEnded;             //画面下部スクロール部フリック判定用座標
    NSTimer *timer;                     //経過時間呼び出し用
    NSDate *stDate;                     //ゲーム開始時刻格納
    NSDate *nowDate;                    //現在時刻格納
    NSString *imageStr[6];              //画面下部スクロール部画名配列
    
    //1種類目の画像1-9
    UIImageView *imageView1_1;
    UIImageView *imageView1_2;
    UIImageView *imageView1_3;
    UIImageView *imageView1_4;
    UIImageView *imageView1_5;
    UIImageView *imageView1_6;
    UIImageView *imageView1_7;
    UIImageView *imageView1_8;
    UIImageView *imageView1_9;
    UIImageView *imageView1_10;
    UIImageView *imageView1_11;
    UIImageView *imageView1_12;
    
    //2種類目の画像1-9
    UIImageView *imageView2_1;
    UIImageView *imageView2_2;
    UIImageView *imageView2_3;
    UIImageView *imageView2_4;
    UIImageView *imageView2_5;
    UIImageView *imageView2_6;
    UIImageView *imageView2_7;
    UIImageView *imageView2_8;
    UIImageView *imageView2_9;
    UIImageView *imageView2_10;
    UIImageView *imageView2_11;
    UIImageView *imageView2_12;
    
    
    //3種類目の画像1-9
    UIImageView *imageView3_1;
    UIImageView *imageView3_2;
    UIImageView *imageView3_3;
    UIImageView *imageView3_4;
    UIImageView *imageView3_5;
    UIImageView *imageView3_6;
    UIImageView *imageView3_7;
    UIImageView *imageView3_8;
    UIImageView *imageView3_9;
    UIImageView *imageView3_10;
    UIImageView *imageView3_11;
    UIImageView *imageView3_12;
    
    //4種類目の画像1-9
    UIImageView *imageView4_1;
    UIImageView *imageView4_2;
    UIImageView *imageView4_3;
    UIImageView *imageView4_4;
    UIImageView *imageView4_5;
    UIImageView *imageView4_6;
    UIImageView *imageView4_7;
    UIImageView *imageView4_8;
    UIImageView *imageView4_9;
    UIImageView *imageView4_10;
    UIImageView *imageView4_11;
    UIImageView *imageView4_12;
    
    //5種類目の画像1-9
    UIImageView *imageView5_1;
    UIImageView *imageView5_2;
    UIImageView *imageView5_3;
    UIImageView *imageView5_4;
    UIImageView *imageView5_5;
    UIImageView *imageView5_6;
    UIImageView *imageView5_7;
    UIImageView *imageView5_8;
    UIImageView *imageView5_9;
    UIImageView *imageView5_10;
    UIImageView *imageView5_11;
    UIImageView *imageView5_12;
    
    //6種類目の画像1-9
    UIImageView *imageView6_1;
    UIImageView *imageView6_2;
    UIImageView *imageView6_3;
    UIImageView *imageView6_4;
    UIImageView *imageView6_5;
    UIImageView *imageView6_6;
    UIImageView *imageView6_7;
    UIImageView *imageView6_8;
    UIImageView *imageView6_9;
    UIImageView *imageView6_10;
    UIImageView *imageView6_11;
    UIImageView *imageView6_12;
}

//画面で使用するオブジェクト
@property (nonatomic,strong) UIImageView *viewImage1;       //画面下部スクロール部左画像
@property (nonatomic,strong) UIImageView *viewImage2;       //画面下部スクロール部中央画像
@property (nonatomic,strong) UIImageView *viewImage3;       //画面下部スクロール部右画像
@property (nonatomic,strong) UIButton *rightButton;         //画面下部スクロール部右ボタン
@property (nonatomic,strong) UIButton *leftButton;          //画面下部スクロール部左ボタン
@property (nonatomic,strong) UILabel  *scoreLabel;          //時給表示用ラベル
@property (nonatomic,strong) UIButton *startButton;         //ゲームスタートボタン
@property (nonatomic,strong) UIButton *stopButton;          //ゲームスタートボタン
@property (nonatomic,strong) UILabel *resultLabel;          //ゲームオーバー表示用ラベル
@property (nonatomic,strong) UIView *item;
@property (nonatomic,strong) UIView *purchaseView;
@property (strong, nonatomic) UILabel *infoLabel;
@property (strong, nonatomic) NSArray *options;


//1種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView1_12;


//2種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView2_12;


//3種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView3_12;

//4種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView4_12;

//5種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView5_12;

//6種類目の画像1-9
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_1;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_2;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_3;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_4;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_5;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_6;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_7;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_8;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_9;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_10;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_11;
@property (nonatomic,strong) IBOutlet UIImageView *imageView6_12;


//IBAction
- (IBAction)rightButtonClick:(id)sender;            //スクロールの右ボタンクリック時動作
- (IBAction)leftButtonClick:(id)sender;             //スクロールの左ボタンクリック時動作
- (IBAction)startGame:(id)sender;                   //スタートボタン押下時のアクション
- (IBAction)displayMenu:(id) sender;                //戻るボタン押下時のアクション


//ゲームロジック
- (void)dispTabImage:(int)pattern;                  //スクロールの画像を表示させる
- (void)pointDisplay;                               //得点の計算と表示
- (void)runGame;                                    //ゲームロジック
- (void)gameOver;                                   //ゲームオーバー時の動作
- (void)pauseGame;                                  //ポーズ時の動作
- (void)beforeRunGame;                              //ゲーム開始前の諸処理
- (void)levelUp;                                    //レベルアップ時の処理
- (void)addItem1;
- (void)addItem2;
- (void)addItem3;
- (void)addItem4;


//画像の非表示
- (void)deleteImage1;                               //1種類目の画像を削除する際の動作
- (void)deleteImage2;                               //2種類目の画像を削除する際の動作
- (void)deleteImage3;                               //3種類目の画像を削除する際の動作
- (void)deleteImage4;                               //4種類目の画像を削除する際の動作
- (void)deleteImage5;                               //5種類目の画像を削除する際の動作
- (void)deleteImage6;                               //6種類目の画像を削除する際の動作

//画像の表示
- (void)touchImage1;                                //1種類目の画像を表示する際の動作
- (void)touchImage2;                                //2種類目の画像を表示する際の動作
- (void)touchImage3;                                //3種類目の画像を表示する際の動作
- (void)touchImage4;                                //4種類目の画像を表示する際の動作
- (void)touchImage5;                                //5種類目の画像を表示する際の動作
- (void)touchImage6;                                //6種類目の画像を表示する際の動作

@end