//
//  CFCycleBannerView.m
//  CFCycleBannerView-Demo
//
//  Created by GCF on 15/11/13.
//  Copyright © 2015年 gcfrun. All rights reserved.
//

#import "CFCycleBannerView.h"
#import "UIImageView+WebCache.h"
@interface CFCycleBannerView ()<UIScrollViewDelegate>
{
    BOOL _isUrl;
}
@property(nonatomic,copy)void (^tapBlock)(NSInteger selectIndex);
@property(nonatomic,strong)UIScrollView     *scrollView;
@property(nonatomic,strong)UIPageControl    *pageControl;
@property(nonatomic,strong)NSTimer          *timer;
@property(nonatomic)NSInteger               currentImageIndex;
@property(nonatomic,strong)UIImageView      *leftImageView;
@property(nonatomic,strong)UIImageView      *centerImageView;
@property(nonatomic,strong)UIImageView      *rightImageView;
@property(nonatomic,copy)NSArray            *imgArr;
@property(nonatomic,copy)NSArray            *urlArr;
@end

@implementation CFCycleBannerView

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.currentImageIndex=0;
    [self insertSubview:self.scrollView atIndex:0];
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
    [self reloadImage];
}

-(id)initWithFrame:(CGRect)frame withUrlArr:(NSArray *)urlArr withTapBlock:(void(^)(NSInteger selectIndex)) block
{
    self=[super initWithFrame:frame];
    {
        _isUrl=YES;
        self.urlArr=[NSArray arrayWithArray:urlArr];
        _tapBlock=block;
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame withImgArr:(NSArray *)imgArr withTapBlock:(void(^)(NSInteger selectIndex)) block
{
    self=[super initWithFrame:frame];
    if (self) {
        _isUrl=NO;
        self.imgArr=[NSArray arrayWithArray:imgArr];
        _tapBlock=block;
    }
    return self;
}

-(void)setImgArr:(NSMutableArray *)imgArr
{
    if (_imgArr!=imgArr) {
        _imgArr=imgArr;
        if (_imgArr.count!=0) {
            self.pageControl.numberOfPages=_imgArr.count;
            [self.pageControl setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_pageControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
        }
    }
}

-(void)setUrlArr:(NSMutableArray *)urlArr
{
    if (_urlArr!=urlArr) {
        _urlArr=urlArr;
        if (_urlArr.count!=0) {
            self.pageControl.numberOfPages=_urlArr.count;
            [self.pageControl setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_pageControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_pageControl]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_pageControl)]];
        }
    }
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.contentSize=CGSizeMake(CGRectGetWidth(self.frame)*3, CGRectGetHeight(self.frame));
        _scrollView.showsHorizontalScrollIndicator=NO;
        _scrollView.showsVerticalScrollIndicator=NO;
        _scrollView.delegate=self;
        _scrollView.pagingEnabled=YES;
        _scrollView.bounces=YES;
        [_scrollView addSubview:self.leftImageView];
        [_scrollView addSubview:self.centerImageView];
        [_scrollView addSubview:self.rightImageView];
    }
    return _scrollView;
}

-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl=[[UIPageControl alloc]init];
        _pageControl.frame=CGRectZero;
        [self addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIImageView *)leftImageView
{
    if (!_leftImageView) {
        _leftImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    }
    return _leftImageView;
}
- (UIImageView *)centerImageView
{
    if (!_centerImageView) {
        _centerImageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        _centerImageView.userInteractionEnabled=YES;
        [_centerImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)]];
    }
    return _centerImageView;
}
- (UIImageView *)rightImageView
{
    if (!_rightImageView) {
        _rightImageView=[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)*2, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    }
    return _rightImageView;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGesture
{
    if (_tapBlock) {
        _tapBlock(_currentImageIndex);
    }
}

-(void)startAnimationWithInterval:(NSInteger)interval
{
    if(!_timer.valid||!_timer){
        _timer=[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerActtion:) userInfo:nil repeats:YES];
    }
}

-(void)stopAnimation
{
    [_timer invalidate];
}

- (void)timerActtion:(NSTimer *)timer
{
    if ((_isUrl&&_urlArr.count>0)||(!_isUrl&&_imgArr.count>0)) {
        [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame)*2, 0) animated:YES];
    }
}

-(void)reloadImage{
    NSInteger leftImageIndex,rightImageIndex;
    CGPoint offset=[_scrollView contentOffset];
    if (offset.x>CGRectGetWidth(self.frame)) { //向右滑动
        _currentImageIndex=(_currentImageIndex+1)%self.pageControl.numberOfPages;
    }else if(offset.x<CGRectGetWidth(self.frame)){ //向左滑动
        _currentImageIndex=(_currentImageIndex+self.pageControl.numberOfPages-1)%self.pageControl.numberOfPages;
    }
    leftImageIndex=(_currentImageIndex+self.pageControl.numberOfPages-1)%self.pageControl.numberOfPages;
    rightImageIndex=(_currentImageIndex+1)%self.pageControl.numberOfPages;
    if(_isUrl)
    {
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_urlArr[_currentImageIndex]]];
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_urlArr[leftImageIndex]]];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_urlArr[rightImageIndex]]];
    }else
    {
        _centerImageView.image=_imgArr[_currentImageIndex];
        _leftImageView.image=_imgArr[leftImageIndex];
        _rightImageView.image=_imgArr[rightImageIndex];
    }
    _pageControl.currentPage=_currentImageIndex;
}

//定时器动作结束
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self reloadImage];
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
   
}

//手势动作结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self reloadImage];
    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.frame), 0) animated:NO];
}

@end
