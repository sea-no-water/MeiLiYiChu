//
//  QT_HeaderView.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/20.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "QT_HeaderView.h"
#import "SYsource.h"
#import "QT_headerModel.h"

#define BtnWIDTH (WIDTH-30)/5

@implementation QT_HeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}



#pragma mark ************* 懒加载
- (UIView * )BtnsView
{
    if (!_BtnsView)
    {
        _BtnsView = [[UIView alloc]init];
//        _BtnsView.frame = CGRectMake(0, 0, WIDTH, <#CGFloat height#>);
//        [self creatBtnsAndLabs:_dataArray];
        [self addSubview:_BtnsView];
    }
    return _BtnsView;
}

- (UIView *)JPTJView
{
    if (!_JPTJView)
    {
        _JPTJView = [[UIView alloc]init];
        
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
        
        [self addSubview:_JPTJView];
    }
    return _JPTJView;
}

- (void)setDataArray:(NSArray *)dataArray {
    
    _dataArray = dataArray;
    
    for (UIView *view in self.BtnsView.subviews) {
        [view removeFromSuperview];
    }
    [self creatBtnsAndLabs:dataArray];
    
}

//创建按钮
- (void)creatBtnsAndLabs:(NSArray * )array
{
    
    for (int i = 0 ; i < array.count; i++)
    {
        UIButton * button = [[UIButton alloc]init];
        button.frame = CGRectMake(i%5*(BtnWIDTH+5)+5, i/5*(BtnWIDTH+25)+5, BtnWIDTH, BtnWIDTH);
        [button sd_setImageWithURL:[NSURL URLWithString:[array[i] pic_url]] forState:UIControlStateNormal];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.BtnsView addSubview:button];
    }
    
    for (int i = 0; i < array.count; i++)
    {
        UILabel * lable = [[UILabel alloc]init];
        lable.frame = CGRectMake(i%5*(BtnWIDTH+5)+5, i/5*(BtnWIDTH+15+10)+BtnWIDTH+5, BtnWIDTH, 20);
        lable.textColor = [UIColor grayColor];
        lable.font = [UIFont systemFontOfSize:12];
        lable.textAlignment = NSTextAlignmentCenter;
        lable.text = [array[i] title];
        [self.BtnsView addSubview:lable];
    }
    long a = array.count/5;
    long b = array.count%5;
    if (b != 0)
    {
        a = a+1;
    }
    self.BtnsView.frame = CGRectMake(0, 0, WIDTH, (BtnWIDTH+15+5)*a);

    self.JPTJView.frame = CGRectMake(0, _BtnsView.frame.size.height+15, WIDTH, 30);


}

- (void)buttonClick:(UIButton * )btn
{
    
}
@end
