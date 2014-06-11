//
//  ScoreViewController.h
//  scrollGame
//
//  Created by 真悟 羽野 on 12/09/18.
//  Copyright (c) 2012年 NNTP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "NewViewController.h"

@interface ScoreViewController : UIViewController
{
    IBOutlet UILabel *scoreLabel1;
    IBOutlet UILabel *scoreLabel2;
    IBOutlet UILabel *scoreLabel3;
    IBOutlet UILabel *scoreLabel4;
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

@property (nonatomic,retain) IBOutlet UILabel *itemLabel1;
@property (nonatomic,retain) IBOutlet UILabel *itemLabel2;
@property (nonatomic,retain) IBOutlet UILabel *itemLabel3;
@property (nonatomic,retain) IBOutlet UILabel *itemLabel4;

-(IBAction) displayView:(id)sender;     //ゲーム画面を表示する
-(void) displayScore:(int[])array;      //各要素をスコア表に表示する

@end
