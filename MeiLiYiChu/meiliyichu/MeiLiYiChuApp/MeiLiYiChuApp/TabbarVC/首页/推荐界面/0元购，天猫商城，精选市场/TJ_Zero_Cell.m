//
//  TJ_Zero_Cell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/19.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "TJ_Zero_Cell.h"
#import "SYsource.h"
@implementation TJ_Zero_Cell
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.frame = CGRectMake(0, 130, WIDTH, 510);
        typeof(self) lsSelf = self;
        
        NSString * urlStr = @"http://api.yuike.com/gmall/api/1.0/home/model_list.php?mid=457465&yk_pid=3&yk_appid=1&yk_cc=huawei&yk_cvc=311&cursor=0&count=40";
        [SYsource getLunBoScImg:^(NSDictionary *dic) {
            
            _dataArray = dic[@"data"];
            [lsSelf addSubview:lsSelf.zeroBtn];
            [lsSelf addSubview:lsSelf.TMFontLab];
            [lsSelf addSubview:lsSelf.TMBackLab];
            [lsSelf addSubview:lsSelf.TMView];
            
            [lsSelf addSubview:lsSelf.JXFontLab];
            [lsSelf addSubview:lsSelf.JXBackLab];
            [lsSelf addSubview:lsSelf.JXView];
            
            [lsSelf addSubview:lsSelf.JPTJView];
        } WithURL:urlStr];

    }
    return self;
}
#pragma mark ************* 懒加载
//0元秒好货
- (UIButton * )zeroBtn
{
    if (!_zeroBtn)
    {
        _zeroBtn = [[UIButton alloc]init];
        _zeroBtn.frame = CGRectMake(0, 0, WIDTH, 100);
        [_zeroBtn addTarget:self action:@selector(ZeroBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        NSString * urlimg = _dataArray.firstObject[@"content_data"][@"pic_url"];
        
        [_zeroBtn sd_setImageWithURL:[NSURL URLWithString:urlimg] forState:UIControlStateNormal];
    }
    return _zeroBtn;
}

- (void)ZeroBtnClick:(UIButton *)button
{
    NSLog(@"0元够");
}

/************************************ 天猫 ***********************************/
- (UILabel * )TMFontLab
{
    if (!_TMFontLab)
    {
        _TMFontLab = [[UILabel alloc]init];
        _TMFontLab.frame = CGRectMake(10, 100, WIDTH, 30);
        _TMFontLab.text = @"天猫商城";
        _TMFontLab.textColor = [UIColor redColor];
        _TMFontLab.font = [UIFont boldSystemFontOfSize:15];
    }
    return _TMFontLab;
}

- (UILabel * )TMBackLab
{
    if (!_TMBackLab)
    {
        _TMBackLab = [[UILabel alloc]init];
        _TMBackLab.frame = CGRectMake(80, 100, WIDTH, 30);
        _TMBackLab.text = @"品质保证";
        _TMBackLab.textColor = [UIColor grayColor];
        _TMBackLab.font = [UIFont systemFontOfSize:12];
    }
    return _TMBackLab;
}

- (UIView *)TMView
{
    if (!_TMView)
    {
        _TMView = [[UIView alloc]init];
        _TMView.frame = CGRectMake(0, 130, WIDTH, 180);
        _TMView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        UIButton * leftBtn = [[UIButton alloc]init];
        leftBtn.frame = CGRectMake(0, 0, WIDTH/2, 180);
        NSArray * leftArr = _dataArray[1][@"content_data"][@"left_part"];
        NSString * urlStr = leftArr[0][@"pic_url"];
        [leftBtn sd_setImageWithURL:[NSURL URLWithString:urlStr] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(TMleftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_TMView addSubview:leftBtn];
        
        UIButton * rightUpBtn = [[UIButton alloc]init];
        rightUpBtn.frame = CGRectMake(WIDTH/2+1, 0, WIDTH/2-1, 89);
        NSArray * rightUpArr = _dataArray[1][@"content_data"][@"right_part"];
        NSString * urlStr1 = rightUpArr[0][@"pic_url"];
        [rightUpBtn sd_setImageWithURL:[NSURL URLWithString:urlStr1] forState:UIControlStateNormal];
        [rightUpBtn addTarget:self action:@selector(TMrightUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_TMView addSubview:rightUpBtn];
        
        
        UIButton * rightDownBtn = [[UIButton alloc]init];
        rightDownBtn.frame = CGRectMake(WIDTH/2+1, 90, WIDTH/2-1, 90);
        NSArray * rightDownArr = _dataArray[1][@"content_data"][@"right_part"];
        NSString * urlStr2 = rightDownArr[1][@"pic_url"];
        [rightDownBtn sd_setImageWithURL:[NSURL URLWithString:urlStr2] forState:UIControlStateNormal];
        [rightDownBtn addTarget:self action:@selector(TMrightDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_TMView addSubview:rightDownBtn];
        
        
    }
    return _TMView;
}
//天猫点击事件
- (void)TMleftBtnClick:(UIButton * )button
{
    NSLog(@"女装上新");
}
- (void)TMrightUpBtnClick:(UIButton * )button
{
    NSLog(@"定格小目标");
}
- (void)TMrightDownBtnClick:(UIButton * )button
{
    NSLog(@"万能斜挎包");
}
/************************************ 精选市场 ***********************************/

- (UILabel * )JXFontLab
{
    if (!_JXFontLab)
    {
        _JXFontLab = [[UILabel alloc]init];
        _JXFontLab.frame = CGRectMake(10, 310, WIDTH, 30);
        _JXFontLab.text = @"精选市场";
        _JXFontLab.textColor = [UIColor redColor];
        _JXFontLab.font = [UIFont boldSystemFontOfSize:15];
    }
    return _JXFontLab;
}

- (UILabel * )JXBackLab
{
    if (!_JXBackLab)
    {
        _JXBackLab = [[UILabel alloc]init];
        _JXBackLab.frame = CGRectMake(80, 310, WIDTH, 30);
        _JXBackLab.text = @"提高时尚品味";
        _JXBackLab.textColor = [UIColor grayColor];
        _JXBackLab.font = [UIFont systemFontOfSize:12];
    }
    return _JXBackLab;
}

- (UIView *)JXView
{
    if (!_JXView)
    {
        _JXView = [[UIView alloc]init];
        _JXView.frame = CGRectMake(0, 340, WIDTH, 140);
        _JXView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        
        
        UIButton * leftUpBtn = [[UIButton alloc]init];
        leftUpBtn.frame = CGRectMake(0, 0, WIDTH/2, 69);
        NSArray * leftUpBtnArr = _dataArray[2][@"content_data"][@"left_part"];
        NSString * urlStr1 = leftUpBtnArr[0][@"pic_url"];
        [leftUpBtn sd_setImageWithURL:[NSURL URLWithString:urlStr1] forState:UIControlStateNormal];
        [leftUpBtn addTarget:self action:@selector(JXleftUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_JXView addSubview:leftUpBtn];
        
        
        UIButton * leftDownBtn = [[UIButton alloc]init];
        leftDownBtn.frame = CGRectMake(0, 70, WIDTH/2, 70);
        NSArray * leftDownBtnArr = _dataArray[2][@"content_data"][@"left_part"];
        NSString * urlStr2 = leftDownBtnArr[1][@"pic_url"];
        [leftDownBtn sd_setImageWithURL:[NSURL URLWithString:urlStr2] forState:UIControlStateNormal];
        [leftDownBtn addTarget:self action:@selector(JXleftDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_JXView addSubview:leftDownBtn];
        
        
        UIButton * rightUpBtn = [[UIButton alloc]init];
        rightUpBtn.frame = CGRectMake(WIDTH/2+1, 0, WIDTH/2-1, 69);
        NSArray * rightUpArr = _dataArray[2][@"content_data"][@"right_part"];
        NSString * urlStr11 = rightUpArr[0][@"pic_url"];
        [rightUpBtn sd_setImageWithURL:[NSURL URLWithString:urlStr11] forState:UIControlStateNormal];
        [rightUpBtn addTarget:self action:@selector(JXrightUpBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_JXView addSubview:rightUpBtn];
        
        
        UIButton * rightDownBtn = [[UIButton alloc]init];
        rightDownBtn.frame = CGRectMake(WIDTH/2+1, 70, WIDTH/2-1, 70);
        NSArray * rightDownArr = _dataArray[2][@"content_data"][@"right_part"];
        NSString * urlStr22 = rightDownArr[1][@"pic_url"];
        [rightDownBtn sd_setImageWithURL:[NSURL URLWithString:urlStr22] forState:UIControlStateNormal];
        [rightDownBtn addTarget:self action:@selector(JXrightDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_JXView addSubview:rightDownBtn];
        
        
    }
    return _JXView;
}
//精选点击事件
- (void)JXleftUpBtnClick:(UIButton * )button
{
    NSLog(@"俏皮出游");
}
- (void)JXleftDownBtnClick:(UIButton * )button
{
    NSLog(@"精美彩妆");
}
- (void)JXrightUpBtnClick:(UIButton * )button
{
    NSLog(@"萌出新意");
}
- (void)JXrightDownBtnClick:(UIButton * )button
{
    NSLog(@"经典");
}

/************************************ 精品推荐lable ***********************************/
- (UIView *)JPTJView
{
    if (!_JPTJView)
    {
        _JPTJView = [[UIView alloc]init];
        _JPTJView.frame = CGRectMake(0, 480, WIDTH, 30);
        
        UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.textColor = [UIColor grayColor];
        lable.text = @"精品推荐";
        lable.font = [UIFont systemFontOfSize:13];
        lable.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
        [_JPTJView addSubview:lable];
        
        UILabel * line1 = [[UILabel alloc]init];
        line1.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        line1.frame = CGRectMake(WIDTH/5-5, 14, WIDTH/5, 1);
        [_JPTJView addSubview:line1];
        
        UILabel * line2 = [[UILabel alloc]init];
        line2.backgroundColor = [UIColor colorWithWhite:0.85 alpha:1];
        line2.frame = CGRectMake(WIDTH/5*3+5, 14, WIDTH/5, 1);
        [_JPTJView addSubview:line2];
        
    }
    return _JPTJView;
}

@end
