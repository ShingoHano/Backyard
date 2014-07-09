//
//  iPadScoreViewController.h
//  backyard
//
//  Created by 羽野 真悟 on 13/06/07.
//  Copyright (c) 2013年 羽野 真悟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iPadScoreViewController : UIViewController
{
    IBOutlet UILabel *scoreLabel1;
    IBOutlet UILabel *scoreLabel2;
    IBOutlet UILabel *scoreLabel3;
    IBOutlet UILabel *scoreLabel4;
    //    IBOutlet UIButton *imageButton;
    //    IBOutlet UIButton *changeButton;
    //    IBOutlet UILabel *changeLabel;
    IBOutlet UIImageView *imageView;
}

@property (nonatomic, strong) UILabel *scoreLabel1;
@property (nonatomic, strong) UILabel *scoreLabel2;
@property (nonatomic, strong) UILabel *scoreLabel3;
@property (nonatomic, strong) UILabel *scoreLabel4;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UILabel *changeLabel;
@property (nonatomic, strong) UIImageView *imageView;

-(IBAction) displayView:(id)sender;     //ゲーム画面を表示する

//-(IBAction) scoreChange:(id)sender;     //現在のスコアとハイスコアの表示切り替え
-(void) displayScore:(int[])array;      //各要素をスコア表に表示する

@end
