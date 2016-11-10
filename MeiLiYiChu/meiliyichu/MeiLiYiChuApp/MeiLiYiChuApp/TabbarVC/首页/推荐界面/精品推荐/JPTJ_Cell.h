//
//  JPTJ_Cell.h
//  MeiLiYiChuApp
//
//  Created by mac on 16/9/18.
//  Copyright © 2016年 刘文海. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPTJ_Cell : UICollectionViewCell
/**
 *  显示图片
 */
@property (nonatomic, strong) UIImageView * imageView;
/**
 *  显示描述
 */
@property (nonatomic, strong) UILabel * detailLab;
/**
 *  显示价格
 */
@property (nonatomic, strong) UILabel * priceLab;
/**
 *  售出的数量
 */
@property (nonatomic, strong) UILabel * soldCountLab;

@end
