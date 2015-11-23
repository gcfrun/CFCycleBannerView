//
//  CFCycleBannerView.h
//  CFCycleBannerView-Demo
//
//  Created by GCF on 15/11/13.
//  Copyright © 2015年 gcfrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFCycleBannerView : UIView
/*初始化*/
-(id)initWithFrame:(CGRect)frame withUrlArr:(NSArray *)urlArr  withTapBlock:(void(^)(NSInteger selectIndex)) block;
-(id)initWithFrame:(CGRect)frame withImgArr:(NSArray *)imgArr  withTapBlock:(void(^)(NSInteger selectIndex)) block;
/*动画*/
-(void)startAnimationWithInterval:(NSInteger)interval;
-(void)stopAnimation;
@end
