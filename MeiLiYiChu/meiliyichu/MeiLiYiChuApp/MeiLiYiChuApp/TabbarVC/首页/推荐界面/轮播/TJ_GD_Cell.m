//
//  TJ_GD_Cell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "TJ_GD_Cell.h"
#import "SYsource.h"
@implementation TJ_GD_Cell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ImgArr = [NSMutableArray array];
        
//        self.frame = CGRectMake(0, 0, WIDTH, 120);
        
        NSString * urlStr = @"http://api.yuike.com/gmall/api/1.0/home/banner_list.php?mid=457465&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=40";
        typeof(self) lsSelf = self;
        [SYsource getLunBoScImg:^(NSDictionary *dic) {
            NSArray * array = dic[@"data"][@"items"];
            for (NSDictionary * dic1 in array)
            {
                NSString * imgUrl = dic1[@"pic_url"];
                [_ImgArr addObject:imgUrl];
            }
            [lsSelf addSubview:lsSelf.lunboSc];
            [lsSelf creatBtn];
            [lsSelf addSubview:lsSelf.page];
            
        } WithURL:urlStr];

        
    }
    return self;
}

#pragma mark ************* 懒加载
- (UIScrollView *)lunboSc
{
    if (!_lunboSc)
    {
        _lunboSc = [[UIScrollView alloc]init];
        _lunboSc.frame = CGRectMake(0, 0, WIDTH, 120);
        _lunboSc.contentSize = CGSizeMake(WIDTH*_ImgArr.count, 120);
        _lunboSc.showsHorizontalScrollIndicator = NO;
        _lunboSc.delegate = self;
        _lunboSc.pagingEnabled = YES;
        _lunboSc.backgroundColor = [UIColor orangeColor];
    }
    return _lunboSc;
}

- (UIPageControl *)page
{
    if (!_page)
    {
        _page = [[UIPageControl alloc]init];
        _page.frame = CGRectMake((WIDTH-100)/2, 120-25, 100, 20 );
        _page.numberOfPages = _ImgArr.count;
        _page.pageIndicatorTintColor = [UIColor whiteColor];
        _page.currentPageIndicatorTintColor = [UIColor redColor];
        
    }
    return _page;
}
#pragma mark ************* 创建图片
- (void)creatBtn
{
    for (int i = 0; i < 4; i ++)
    {
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(i*WIDTH, 0, WIDTH, 120);
        btn.tag = i;
        [btn sd_setImageWithURL:_ImgArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_lunboSc addSubview:btn];
    }
    [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(removeImage) userInfo:nil repeats:YES];
}

- (void)removeImage
{
    static int a=1;
    NSInteger b =  _page.currentPage;
    
    if (b == _ImgArr.count-1)
    {
        a = -1;
    }
    if (b==0)
    {
        a = 1;
    }
    b += a;
    _page.currentPage = b;
    [_lunboSc setContentOffset:CGPointMake(b*WIDTH, 0) animated:YES];
}

//偏移量动画后 同步pc 和 sc
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    float x = _lunboSc.contentOffset.x;
    _page.currentPage = x/WIDTH;
}
//滚动结束 同步pc 和 sc
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float x = _lunboSc.contentOffset.x;
    _page.currentPage = x/WIDTH;
}

- (void)btnClick:(UIButton *)btn
{
    NSLog(@"%ld",btn.tag);
}
@end
