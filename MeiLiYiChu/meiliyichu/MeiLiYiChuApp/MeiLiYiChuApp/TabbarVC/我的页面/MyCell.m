//
//  MyCell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/9.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

        
    }
    return self;
}


#pragma mark ************* 懒加载

- (UIView * )isFiveView
{
    NSArray * NameArr = @[@"待付款",@"待发货",@"待收货",@"已收货",@"退款中"];
    
    if (!_isFiveView)
    {
        _isFiveView = [[UIView alloc]init];
        _isFiveView.frame = CGRectMake(0, 0, WIDTH, 45);
        [self addSubview:_isFiveView];
        
        for (int i = 0; i < 5; i ++)
        {
            UIButton * button = [[UIButton alloc]init];
            button.frame = CGRectMake((WIDTH-30)/9*i*2+25, 5, 20, 23);
            button.tag = i;
            [button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",NameArr[i]]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [_isFiveView addSubview:button];
            
            UILabel * label = [[UILabel alloc]init];
            label.frame = CGRectMake((WIDTH-30)/9*i*2+15, 30, 40, 10);
            label.text = NameArr[i];
            label.textColor = [UIColor colorWithWhite:0.5 alpha:1];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont systemFontOfSize:11];
            [_isFiveView addSubview:label];
            
            UILabel * line = [[UILabel alloc]init];
            line.frame = CGRectMake(0, 0, WIDTH, 1);
            line.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            [_isFiveView addSubview:line];
            
        }
    
    }
    return _isFiveView;
}

- (UIImageView * )FontImageView
{
    if (!_FontImageView)
    {
        _FontImageView = [[UIImageView alloc]init];
        _FontImageView.frame = CGRectMake(10, 5, 25, 30);
        [self addSubview:_FontImageView];
    }
    return _FontImageView;
}

- (UIImageView * )BackImageView
{
    if (!_BackImageView)
    {
        _BackImageView = [[UIImageView alloc]init];
        _BackImageView.frame = CGRectMake(WIDTH - 15, 15, 10, 10);
        [self addSubview:_BackImageView];
    }
    return _BackImageView;
}

- (UILabel *)FontLab
{
    
    if (!_FontLab)
    {
        _FontLab = [[UILabel alloc]init];
        _FontLab.frame = CGRectMake(45, 10, 100, 20);
        _FontLab.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _FontLab.font = [UIFont systemFontOfSize:15];
        _FontLab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_FontLab];
    }
    return _FontLab;
    
}

- (UILabel * )BackLab
{
    if (!_BackLab)
    {
        _BackLab = [[UILabel alloc]init];
        _BackLab.frame = CGRectMake(WIDTH-200, 10, 100, 20);
        _BackLab.textColor = [UIColor colorWithWhite:0.7 alpha:1];
        _BackLab.font = [UIFont systemFontOfSize:13];
        [self addSubview:_BackLab];
    }
    return _BackLab;
}

- (UILabel * )LineLab
{
    if (!_LineLab)
    {
        _LineLab = [[UILabel alloc]init];
        _LineLab.frame = CGRectMake(45, 39, WIDTH, 1);
        _LineLab.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self addSubview:_LineLab];
    }
    return _LineLab;
}

//button的点击事件
- (void)buttonAction:(UIButton * )btn
{
    NSLog(@"这是个测试的输出-tag --- %ld",btn.tag);
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
