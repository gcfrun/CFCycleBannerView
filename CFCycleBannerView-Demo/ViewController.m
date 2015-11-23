//
//  ViewController.m
//  CFCycleBannerView-Demo
//
//  Created by GCF on 15/11/13.
//  Copyright © 2015年 gcfrun. All rights reserved.
//

#import "ViewController.h"
#import "CFCycleBannerView.h"
@interface ViewController ()
@property(nonatomic,strong)CFCycleBannerView *bannerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableArray *mutabArr=[NSMutableArray arrayWithCapacity:5];
    for (int i=1; i<6; i++) {
        [mutabArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",i]]];
    }
//    _bannerView=[[CFCycleBannerView alloc]initWithFrame:CGRectMake(30, 50, 300, 200) withImgArr:mutabArr withTapBlock:^(NSInteger selectIndex) {
//        NSLog(@"%ld",selectIndex);
//    }];
    
    _bannerView=[[CFCycleBannerView alloc]initWithFrame:CGRectMake(30, 50, 300, 200) withUrlArr:@[@"http://pic17.nipic.com/20111120/8245385_190832207000_2.jpg",@"http://pic16.nipic.com/20110909/8338367_111834255106_2.jpg"]withTapBlock:^(NSInteger selectIndex) {
        NSLog(@"%ld",selectIndex);
    }];
    
    _bannerView.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0);
    [self.view addSubview:_bannerView];
    UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame=CGRectMake(0, 0, 150, 30);
    [startBtn setTitle:@"开始滚动" forState:UIControlStateNormal];
    startBtn.backgroundColor=[UIColor blueColor];
    [startBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    startBtn.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0+120);
    [startBtn addTarget:self action:@selector(startAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    UIButton *stopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame=CGRectMake(0, 0, 150, 30);
    [stopBtn setTitle:@"停止滚动" forState:UIControlStateNormal];
    stopBtn.backgroundColor=[UIColor blueColor];
    [stopBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    stopBtn.center=CGPointMake(CGRectGetWidth(self.view.frame)/2.0, CGRectGetHeight(self.view.frame)/2.0+180);
    [stopBtn addTarget:self action:@selector(stoptAct:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)startAct:(UIButton *)btn
{
    [_bannerView startAnimationWithInterval:1];
}

- (void)stoptAct:(UIButton *)btn
{
    [_bannerView stopAnimation];
}

@end
