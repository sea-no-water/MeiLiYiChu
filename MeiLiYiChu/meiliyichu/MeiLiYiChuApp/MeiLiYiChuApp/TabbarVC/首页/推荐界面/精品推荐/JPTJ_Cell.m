//
//  JPTJ_Cell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "JPTJ_Cell.h"


#define ITEMWITH (WIDTH-30)/2

@implementation JPTJ_Cell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
    }
    return self;
}


#pragma mark ************* 懒加载
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        _imageView.frame = CGRectMake(0, 0, ITEMWITH, ITEMWITH);
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)detailLab
{
    if (!_detailLab)
    {
        _detailLab = [[UILabel alloc]init];
        _detailLab.frame = CGRectMake(5, ITEMWITH+5, ITEMWITH-10, 40);
        _detailLab.numberOfLines = 2;
        _detailLab.font = [UIFont systemFontOfSize:13];
        _detailLab.textColor = [UIColor grayColor];
        [self addSubview:_detailLab];
    }
    return _detailLab;
    
}

- (UILabel * )priceLab
{
    if (!_priceLab)
    {
        _priceLab = [[UILabel alloc]init];
        _priceLab.textColor = [UIColor redColor];
        _priceLab.font = [UIFont systemFontOfSize:13];

        [self addSubview:_priceLab];
    }
    return _priceLab;
}

- (UILabel *)soldCountLab
{
    if (!_soldCountLab)
    {
        _soldCountLab = [[UILabel alloc]init];
        _soldCountLab.textColor = [UIColor lightGrayColor];
        _soldCountLab.font = [UIFont systemFontOfSize:11];
        
        [self addSubview:_soldCountLab];
    }
    return _soldCountLab;
    
}



@end
