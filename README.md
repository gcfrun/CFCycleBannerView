# CFCycleBannerView
banner页循环轮播，可以加载url图片，也可以加载本地图片，支持点击事件响应、动画。
## 公有方法
```
/*初始化*/
-(id)initWithFrame:(CGRect)frame withUrlArr:(NSArray *)urlArr  withTapBlock:(void(^)(NSInteger selectIndex)) block;
-(id)initWithFrame:(CGRect)frame withImgArr:(NSArray *)imgArr  withTapBlock:(void(^)(NSInteger selectIndex)) block;
/*动画*/
-(void)startAnimationWithInterval:(NSInteger)interval;
-(void)stopAnimation;
```
## 核心代码
```
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

```
