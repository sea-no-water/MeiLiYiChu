//
//  My_CollectionViewCell.m
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/8.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import "My_CollectionViewCell.h"

#define ITEMHEIGHT self.bounds.size.height
#define ITEMWIDTH self.bounds.size.width
@implementation My_CollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor redColor];
        
        _Image = [[UIImageView alloc]init];
        _Image.frame = CGRectMake(0, 0, ITEMWIDTH, ITEMHEIGHT-60);
        _Image.image = [UIImage imageNamed:@"flower.jpeg"];
        [self addSubview:_Image];
        
        _discripton = [[UILabel alloc]init];
        _discripton.frame = CGRectMake(5, ITEMHEIGHT-60, ITEMWIDTH-10, 40);
        _discripton.font = [UIFont systemFontOfSize:12];
        _discripton.textColor = [UIColor colorWithWhite:0.3 alpha:1];
        _discripton.numberOfLines = 2;
        [self addSubview:_discripton];
        
        _nPrice = [[UILabel alloc]init];
        _nPrice.font = [UIFont systemFontOfSize:13];
        _nPrice.textColor = [UIColor redColor];
        [self addSubview:_nPrice];
        
        _oldPrice = [[UILabel alloc]init];
        _oldPrice.font = [UIFont systemFontOfSize:13];
        _oldPrice.textColor = [UIColor lightGrayColor];
        [self addSubview:_oldPrice];
        
        _zheLab = [[UILabel alloc]init];
        _zheLab.font = [UIFont systemFontOfSize:11];
        _zheLab.textColor = [UIColor whiteColor];
        _zheLab.textAlignment = NSTextAlignmentCenter;
        _zheLab.backgroundColor = [UIColor redColor];
        _zheLab.layer.cornerRadius = 4;
        _zheLab.layer.masksToBounds = YES;
        [self addSubview:_zheLab];
        
    }
    return self;
    
    
}


- (void)awakeFromNib {
    // Initialization code
}

@end
